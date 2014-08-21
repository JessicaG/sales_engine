require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def invoice_item_repository
    rows = RepositoryParser.load('./test/fixtures/invoice_items.csv')
    invoice_item_repository = InvoiceItemRepository.new("engine",rows)
  end

  def test_it_can_load_a_repository
    assert_equal 25, invoice_item_repository.invoice_items.length
  end

  def test_it_returns_basic_information
    information = invoice_item_repository.inspect
    assert_equal "#<InvoiceItemRepository 25 rows>", information
  end

  def test_it_returns_a_random_customer
    random_invoice_item1 = invoice_item_repository.random
    random_invoice_item2 = invoice_item_repository.random

    refute random_invoice_item1 == random_invoice_item2
  end

  def test_it_can_return_all_items_in_the_repository
    assert_equal 25, invoice_item_repository.all.count
  end

  def test_it_can_find_invoice_items_by_id
    result = invoice_item_repository.find_by_id('1')
    assert_equal '1', result.id
  end

  def test_it_can_find_invoice_items_by_item_id
    result = invoice_item_repository.find_by_item_id('534')
    assert_equal '534', result.item_id
  end

  def test_it_can_find_all_invoice_items_with_a_specific_quantitity
    result = invoice_item_repository.find_all_by_quantity('5')
    assert_equal 5, result.count
  end

  def test_it_can_find_all_invoice_items_from_a_specific_invoice
    result = invoice_item_repository.find_all_by_invoice_id('3')
    assert_equal 8, result.count
  end


end
