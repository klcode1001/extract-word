class ExtractWord
  def execute(file_path)
    text = File.read(file_path)
    words = count_words(text)
    single_words, compund_words = words.partition { |word, _| word.count(' ').zero? }
    output_result(single_words, compund_words)
  end

  private

  def count_words(text)
    regex = /(?:[A-Z][\w\/’]*(?:\sof|\s[A-Z][\w\/’]*)+|[\w’-]+)/
    text.scan(regex).each_with_object(Hash.new(0)) do |word, count_table|
      count_table[word] += 1
    end
  end

  def output_result(single_words, compound_words)
    word_count = single_words.inject(0) {|sum, (_, count)| sum + count}
    puts "単語数（熟語以外）：#{word_count}"
    output_words(compound_words, '英熟語？')
    output_words(single_words, '英単語')
  end

  def output_words(count_table, header)
    puts "#{header}------------------------------------------------------------------"
    count_table.sort_by{|_, v| [-v, _]}.each do |word, count|
      puts "%3d %s" % [count, word]
    end
  end
end