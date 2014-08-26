require_relative 'test_helper'
# require 'pry'

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
    assert associated_items.count > 0
    assert associated_items.all? {|item| item.merchant_id == merchant.id}
  end

  def test_merchant_can_find_associated_invoices
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    associated_invoices = merchant.invoices
    assert associated_invoices.count > 0
    assert associated_invoices.all? {|invoice| invoice.merchant_id == merchant.id}
  end

  def test_invoice_can_find_associated_transactions
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_transactions = invoice.transactions
    assert associated_transactions.count > 0
    assert associated_transactions.all? {|transaction| transaction.invoice_id == invoice.id}
  end

  def test_transcation_returns_associated_invoice
    transaction = engine.transaction_repository.find_by('invoice_id', '7')
    invoice = transaction.invoice
    assert_equal ('7'), invoice.id
  end

  def test_customer_returns_associated_invoices
    customer = engine.customer_repository.find_by_first_name('Joey')
    assert_equal 9, customer.invoices.map.count(&:customer_id)
  end

  def test_invoice_returns_associated_invoice_items
    item = engine.item_repository.find_by('id', '1')
    assert_equal 3, item.invoice_items.count
  end

  def test_item_returns_associated_merchant
    item = engine.item_repository.find_by('merchant_id', '1')
    assert_equal '1', item.merchant.id
  end

  def test_invoice_item_returns_associated_invoice
    invoice_item = engine.invoice_item_repository.find_by('id', '16')
    invoice = invoice_item.invoice
    assert_equal '3', invoice.id
  end

  def test_invoice_item_returns_associated_item
    invoice_item = engine.invoice_item_repository.find_by('item_id', '2')
    item = invoice_item.item
    assert_equal '2', item.id
  end

  def test_invoice_can_find_associated_invoice_items
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_invoice_items = invoice.invoice_items
    assert associated_invoice_items.count > 0
    assert associated_invoice_items.all? {|invoice_item| invoice_item.invoice_id == invoice.id}
  end

  def test_invoice_can_find_associated_items
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_invoice_items = invoice.invoice_items
    associated_items = invoice.items

    associated_invoice_items_item_ids = associated_invoice_items.map do |invoice_item|
      invoice_item.item_id
      end
    assert associated_invoice_items_item_ids.include?(associated_items.sample.id)
  end

  def test_invoice_can_find_an_instance_of_customer_associated_with_itself
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.customer_id == "1"
      end

    associated_customer = invoice.customer
    assert associated_customer.id == "1"
  end

  def test_invoice_can_find_associated_merchant_by_merchant_id
      invoice = engine.invoice_repository.invoices.detect do |invoice|
        invoice.id == "1"
      end

      associated_merchant = invoice.merchant

      assert associated_merchant.id == invoice.merchant_id

  end


end
