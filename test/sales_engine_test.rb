require_relative 'test_helper'

class SalesEngineTest< Minitest::Test



  def test_respositories_are_loaded_at_startup
    engine = SalesEngine.new
    engine.startup

    assert_equal 25, engine.merchant_repository.merchants.length
    assert_equal 25, engine.invoice_repository.invoices.length
    assert_equal 25, engine.item_repository.items.length
    assert_equal 25, engine.invoice_item_repository.invoice_items.length
    assert_equal 25, engine.customer_repository.customers.length
    assert_equal 25, engine.transaction_repository.transactions.length
  end

  def test_find_items_by_merchant_id
    engine = SalesEngine.new
    engine.startup
    items = engine.find_items_by_merchant_id("2")
    assert_equal 10, items.count
  end



end
