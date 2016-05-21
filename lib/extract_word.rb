class ExtractWord
  def self.execute(file_path)
    self.new.execute(file_path)
  end

  def execute(file_path)
    text = File.read(file_path)
    words = count_words(text)
    single_words, compound_words = words.partition { |word, _| word.count(' ').zero? }
    output_result(single_words, compound_words)
  end

  private

  def count_words(text)
    # 単語の構成文字
    word_char = '[\w’\/-]'
    # Google Play Awards や Clash of Kings のような複合語を検索する
    compound_words = /[A-Z]#{word_char}*(?:\sof|\s[A-Z]#{word_char}*)+/
    # 英単語を検索する
    words = /#{word_char}+/
    regex = Regexp.union(compound_words, words)
    text.scan(regex).each_with_object(Hash.new(0)) do |word, count_table|
      count_table[word] += 1
    end
  end

  def output_result(single_words, compound_words)
    word_count = single_words.inject(0) { |sum, (_, count)| sum + count }
    puts "単語数（熟語以外）：#{word_count}"
    output_words(compound_words, '英熟語？')
    output_words(single_words, '英単語')
  end

  def output_words(count_table, header)
    puts "#{header}------------------------------------------------------------------"
    sorted_table = count_table.sort_by { |word, count| [-count, word.downcase] }
    sorted_table.each do |word, count|
      puts '%3d %s' % [count, word]
    end
  end
end