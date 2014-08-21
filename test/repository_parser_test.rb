require_relative 'test_helper'
class DummyClass
  attr_reader :content

  def initialize(data)
    @content = data
  end
end

class RepositoryParserTest < Minitest::Test

  def test_it_load_the_correct_information
    items = RepositoryParser.load('test/fixtures/invoice_items.csv')
    items = items.collect { |row| DummyClass.new(row) }

    assert_equal "1", items[0].content[:id]
    assert_instance_of DummyClass, items[0]
  end
end
