class ExtractWord

  def initialize
    @word = Hash.new(0) # 通常の英単語
    @word_sp = Hash.new(0) # 複数の単語で意味をなす英単語 ex) "Google Play Awards"
    file_path = File.expand_path('../../test.txt', __FILE__)
    @file = File.open(file_path, 'r').read
  end

  def get_word_sp # 複数の単語で意味をなす英単語を取得するメソッド ex) "Google Play Awards"
    reg2 = /([A-Z]\w*\s)([A-Z]\w*\s)/
    reg3 = /([A-Z]\w*\s)([A-Z]\w*\s)([A-Z]\w*\s)/
    reg4 = /([A-Z]\w*\s)([A-Z]\w*\s)([A-Z]\w*\s)([A-Z]\w*\s)/
    reg5 = /([A-Z]\w*\s)([A-Z]\w*\s)([A-Z]\w*\s)([A-Z]\w*\s)([A-Z]\w*\s)/

    array =  @file.scan(reg5)
    array.each do |word|
      key = word.join(",").gsub(",", "").strip
      @word_sp[key] += 1
    end
    array =  @file.scan(reg4)
    array.each do |word|
      key = word.join(",").gsub(",", "").strip
      @word_sp[key] += 1
    end
    array =  @file.scan(reg3)
    array.each do |word|
      key = word.join(",").gsub(",", "").strip
      @word_sp[key] += 1
    end
    array =  @file.scan(reg2)
    array.each do |word|
      key = word.join(",").gsub(",", "").strip
      @word_sp[key] += 1
    end

    get_word
  end

  def get_word
    array = []
    @word_sp.each do |word, frequency|
      array = @file.gsub("#{word}", "")
    end

    array = array.split("\s").map{|m| m.gsub(/\.|\”|\,|\n|\“/, "")}
    array.each do |word|
      @word[word] += 1
    end
    puts "文字数：#{array.count}"
    puts "英熟語？---------------------------------------------------------------"
    @word_sp.sort_by{|_, v| -v}.each do |word, frequency|
      puts "%3d %s" % [frequency, word]
    end
    puts "英単語------------------------------------------------------------------"
    @word.sort_by{|_, v| -v}.each do |word, frequency|
      puts "%3d %s" % [frequency, word]
    end
  end
end