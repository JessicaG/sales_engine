require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test

  def test_it_loads_items_by_default
    item_repository = ItemRepository.new

    assert_equal 2483, item_repository.items.length
  end

  def test_it_can_load_other_items
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    assert_equal 25, item_repository.items.length
  end

  def test_it_returns_an_array_of_customers
    item_repository = ItemRepository.new('./test/fixtures/items.csv').all

    assert item_repository.is_a?(Array)
    assert item_repository.first.is_a?(Item)
  end

  def test_it_returns_a_random_object
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    random_item_1 = item_repository.random
    random_item_2 = item_repository.random

    refute random_item_1 == random_item_2
  end

  def test_it_finds_by_an_attribute_and_match
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    item = item_repository.find_by_id_number("2")


    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
  end

  def test_it_finds_all_items_by_an_attribute
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    
  end

end
