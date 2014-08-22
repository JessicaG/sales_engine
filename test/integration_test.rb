require_relative 'test_helper'
require 'pry'

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

  def test_transcation_returns_associated_invoices
    transaction = engine.transaction_repository.find_by('invoice_id', '7')
    invoice = transaction.invoice
    assert_equal ('6'), transaction.id
    # assert ['6'], transaction.invoice.map(&:invoice_id)
  end

  def test_customer_returns_associated_invoices
    customer = engine.customer_repository.find_by_first_name('Joey')
    invoices = customer.invoices
    assert ['1', '2', '3', '4', '5', '6', '7', '8'], customer.invoices.map.count(&:customer_id)
  end

  def test_invoice_returns_associated_invoice_items
    item = engine.item_repository.find_by('id', '10')
    invoice_items = item.invoice_items
    assert ['4', '6', '8'], item.invoice_items.map(&:id)
  end

  def test_merchant_returns_associated_items
    item = engine.item_repository.find_by('merchant_id', '1')
    merchant = item.merchant
    assert ['1'], item.merchant.id
  end

  def test_invoice_return_associated_invoice_items
    skip
    invoice_items = engine.invoice_item_repository.find_by('invoice_id', '2')
    invoice = invoice_items.invoice
    assert ['2'], invoice_items.invoice
  end

  def test_items_return_associated_invoice_items
    skip
    invoice_items = engine.invoice_item_repository.find_by('item_id', '10')
    item = invoice_items.item
    assert_equal ['pooper scooper'], invoice_items.item.name
  end

  def test_invoice_can_find_associated_invoice_items
    invoice = engine.invoice_repository.invoices.detect do |invoice|
      invoice.id == "1"
    end

    associated_invoice_items = invoice.invoice_items
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
