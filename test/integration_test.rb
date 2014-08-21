require_relative 'test_helper'

class IntegrationTest< Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_merchant_can_find_associated_item_instances
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    associated_items = merchant.items

    assert associated_items.all? {|item| item.merchant_id == merchant.id}

  end

  def test_random_merchant_can_find_associated_invoices
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    associated_invoices = merchant.invoices

    assert associated_invoices.all? {|invoice| invoice.merchant_id == merchant.id}
  end

  def test_random_invoice_can_find_associated_transactions
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_transactions = invoice.transactions

    assert associated_transactions.all? {|transaction| transaction.invoice_id == invoice.id}

  end
end
