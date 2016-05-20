class ExtractWord
  def execute(file_path)
    text = File.open(file_path, 'r').read
    word_sp, processed_text = get_word_sp(text)
    word = get_word(processed_text)
    output_result(word_sp, word)
  end

  private

  # 複数の単語で意味をなす英単語を取得するメソッド ex) "Google Play Awards"
  def get_word_sp(text)
    regex = /[A-Z][\w\/’]*(?:\sof|\s[A-Z][\w\/’]*)+/
    word_sp = Hash.new(0)
    processed_text = text.gsub(regex) do |word, hash|
      word_sp[word] += 1
      ''
    end
    [word_sp, processed_text]
  end

  # 通常の英単語
  def get_word(text)
    word = Hash.new(0)
    text = text.split("\s").map{|m| m.gsub(/[.”,\n“]/, "")}
    text.each do |w|
      word[w] += 1
    end
    word
  end

  def output_result(word_sp, word)
    word_count = word.inject(0) {|sum, (_, count)| sum + count}
    puts "単語数（熟語以外）：#{word_count}"
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