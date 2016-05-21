require 'minitest/autorun'
require_relative '../lib/extract_word'

class ExtractWordTest < Minitest::Test
  def test_greeting
    assert_output(expected_output) { ExtractWord.execute(input_file_path) }
  end

  private

  def input_file_path
    File.expand_path('../input.txt', __FILE__)
  end

  def expected_output
    file_path = File.expand_path('../expected_output.txt', __FILE__)
    File.read(file_path)
  end
end