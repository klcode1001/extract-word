class ExtractWord
  def execute(file_path)
    text = File.open(file_path, 'r').read
    word_sp = get_word_sp(text)
    array, word = get_word(text, word_sp)
    output_result(array, word_sp, word)
  end

  private

  # 複数の単語で意味をなす英単語を取得するメソッド ex) "Google Play Awards"
  def get_word_sp(text)
    regex = /[A-Z][\w\/’]*(?:\sof|\s[A-Z][\w\/’]*)+/
    text.scan(regex).each_with_object(Hash.new(0)) do |word, hash|
      hash[word] += 1
    end
  end

  # 通常の英単語
  def get_word(text, word_sp)
    array = text
    word_sp.keys.sort_by{|s| s.split(/\s/).size * -1}.each do |word|
      array = array.gsub("#{word}", "")
    end

    word = Hash.new(0)
    array = array.split("\s").map{|m| m.gsub(/[.”,\n“]/, "")}
    array.each do |w|
      word[w] += 1
    end
    [array, word]
  end

  def output_result(array, word_sp, word)
    puts "文字数：#{array.count}"
    puts "英熟語？---------------------------------------------------------------"
    word_sp.sort_by{|_, v| [-v, _]}.each do |word, frequency|
      puts "%3d %s" % [frequency, word]
    end
    puts "英単語------------------------------------------------------------------"
    word.sort_by{|_, v| [-v, _]}.each do |word, frequency|
      puts "%3d %s" % [frequency, word]
    end
  end
end