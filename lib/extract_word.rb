class ExtractWord
  def self.execute(file_path)
    self.new.execute(file_path)
  end

  def execute(file_path)
    text = File.read(file_path)
    compound_words, single_words = count_words(text)
    output_result(single_words, compound_words)
  end

  private

  def count_words(text)
    # 単語の構成文字
    word_char = '[\w’\/-]'
    # Google Play Awards や Clash of Kings のような複合語を検索する
    compound_words = /[A-Z]#{word_char}*(?: of| [A-Z]#{word_char}*)+/
    # 英単語を検索する
    words = /#{word_char}+/
    # 複合語が優先的に検索されるように正規表現を結合する
    regex = Regexp.union(compound_words, words)
    # 検索された複合語や英単語をカウント => ソート => グループ分け
    text.scan(regex)
      .each_with_object(Hash.new(0)) { |word, hash| hash[word] += 1 }
      .sort_by { |word, count| [-count, word.downcase] }
      .partition { |word, _| word.include?(' ') }
  end

  def output_result(single_words, compound_words)
    word_count = single_words.map(&:last).inject(:+)
    puts "単語数（熟語以外）：#{word_count}"
    output_words(compound_words, '英熟語？')
    output_words(single_words, '英単語')
  end

  def output_words(count_table, header)
    puts "#{header}------------------------------------------------------------------"
    count_table.each do |word, count|
      puts '%3d %s' % [count, word]
    end
  end
end