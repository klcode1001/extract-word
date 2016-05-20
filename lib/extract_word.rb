class ExtractWord
  def execute(file_path)
    text = File.read(file_path)
    word_sp = get_word_sp(text)
    groups = word_sp.partition{|word, _| !word.count(' ').zero? }
    output_result(*groups)
  end

  private

  def get_word_sp(text)
    regex = /(?:[A-Z][\w\/’]*(?:\sof|\s[A-Z][\w\/’]*)+|[\w’-]+)/
    text.scan(regex).each_with_object(Hash.new(0)) do |word, word_sp|
      word_sp[word] += 1
    end
  end

  def output_result(word_sp, word)
    word_count = word.inject(0) {|sum, (_, count)| sum + count}
    puts "単語数（熟語以外）：#{word_count}"
    output_words(word_sp, '英熟語？')
    output_words(word, '英単語')
  end

  def output_words(word_hash, header)
    puts "#{header}------------------------------------------------------------------"
    word_hash.sort_by{|_, v| [-v, _]}.each do |word, frequency|
      puts "%3d %s" % [frequency, word]
    end
  end
end