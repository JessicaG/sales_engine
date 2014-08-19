require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_loads_items_by_default
    item_repository = ItemRepository.new

    assert_equal 2483, item_repository.items.length
  end

  def test_it_can_load_other_items
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    assert_equal 25, item_repository.items.length
  end
end
