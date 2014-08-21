require_relative 'test_helper'

class IntegrationTest< Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_random_merchant_can_find_associated_item_instances
    merchant = engine.merchant_repository.detect {|merchant| merchant.id = 1}

    associated_items = merchant.items

    assert associated_items.all? {|item| item.merchant_id == random_merchant.id}

  end

  def test_random_merchant_can_find_associated_invoices
    random_merchant = engine.merchant_repository.random

    associated_invoices = random_merchant.invoices

    assert associated_invoices.all? {|invoice| invoice.merchant_id == random_merchant.id}
  end

  def test_random_invoice_can_find_associated_transactions
    skip
    random_invoice = engine.invoice_repository.random

    associated_transactions = random_invoice.transactions

    assert associated_transactions.all? {|transaction| transaction.invoice_id == random_transaction.id}

  end
end
