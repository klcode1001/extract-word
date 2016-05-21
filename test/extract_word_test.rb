require 'minitest/autorun'
require_relative '../lib/extract_word'

class ExtractWordTest < Minitest::Test
  def test_execute
    assert_equal expected_text.strip, ExtractWord.execute(input_file_path)
  end

  private

  def input_file_path
    File.expand_path('../input.txt', __FILE__)
  end

  def expected_text
    file_path = File.expand_path('../expected_output.txt', __FILE__)
    File.read(file_path)
  end
end