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

  def test_merchant_can_find_associated_invoices
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    associated_invoices = merchant.invoices

    assert associated_invoices.all? {|invoice| invoice.merchant_id == merchant.id}
  end

  def test_invoice_can_find_associated_transactions
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_transactions = invoice.transactions

    assert associated_transactions.all? {|transaction| transaction.invoice_id == invoice.id}

  end

  def test_invoice_can_find_associated_invoice_items
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_invoice_items = invoice.invoice_items

    assert associated_invoice_items.all? {|invoice_item| invoice_item.invoice_id == invoice.id}
  end

  def test_invoice_can_find_associated_items
    skip
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_invoice_items = invoice.invoice_items
    associated_items = invoice.items

    associated_invoice_items_item_ids = associated_invoice_items.map do |invoice_item| invoice_item.item_id
      end
    p associated_invoice_items_item_ids
    p associated_items

    assert associated_invoice_items_item_ids.include?(associated_items.sample.id)
  end

  def test_invoice_can_find_an_instance_of_customer_associated_with_itself
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.customer_id == "1"
    end

    associated_customer = invoice.customer

    assert associated_customer.id == "1"
  end
end
