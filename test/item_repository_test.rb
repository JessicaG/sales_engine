require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test

  def item_repository
    rows = RepositoryParser.load('./test/fixtures/items.csv')
    item_repository = ItemRepository.new('engine',rows)
  end

  def test_it_can_load_a_repository
    assert_equal 25, item_repository.items.length
  end

  def test_it_returns_basic_information
    information = item_repository.inspect
    assert_equal "#<ItemRepository 25 rows>", information
  end

  def test_it_returns_a_random_customer
    random_item1 = item_repository.random
    random_item2 = item_repository.random

    refute random_item1 == random_item2
  end

  def test_it_can_return_all_items_in_the_repository
    assert_equal 25, item_repository.all.count
  end

  def test_it_can_find_items_by_id
    result = item_repository.find_by_id('1')
    assert_equal '1', result.id
  end

  def test_it_can_find_all_items_by_merhcant_id
    result = item_repository.find_all_by_merchant_id('2')
    assert_equal 10, result.count
  end

end
