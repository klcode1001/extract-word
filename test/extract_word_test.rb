require 'minitest/autorun'
require_relative '../lib/extract_word'

class ExtractWordTest < Minitest::Test
  def test_greeting
    extract_word = ExtractWord.new
    assert_output(expected_output) { extract_word.execute(file_path) }
  end

  private

  def file_path
    File.expand_path('../../test.txt', __FILE__)
  end

  def expected_output
    file_path = File.expand_path('../expected_output.txt', __FILE__)
    File.read(file_path)
  end
end