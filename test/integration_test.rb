require_relative 'test_helper'

class IntegrationTest< Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_random_merchant_can_find_associated_item_instances
    random_merchant = engine.merchant_repository.random
    random_merchant_id = random_merchant.id

    associated_items = random_merchant.items

    assert associated_items.all? {|item| item.merchant_id == random_merchant_id}

  end

  def test_random_merchant_can_find_associated_invoices
    random_merchant = engine.merchant_repository.random
    random_merchant_id = random_merchant.id

    associated_invoices = random_merchant.invoices

    assert associated_invoices.all? {|invoice| invoice.merchant_id == merchants_id}
  end
end
