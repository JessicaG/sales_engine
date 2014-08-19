require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_loads_items_by_default
    invoice_item_repository = InvoiceItemRepository.new

    assert_equal 21687, invoice_item_repository.invoice_items.length
  end

  def test_it_can_load_other_items
    invoice_item_repository = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')

    assert_equal 25, invoice_item_repository.invoice_items.length
  end
end
