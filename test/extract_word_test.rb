require 'minitest/autorun'
require_relative '../lib/extract_word'

class ExtractWordTest < Minitest::Test
  def test_greeting
    extract_word = ExtractWord.new
    extract_word.get_word_sp
  end
end