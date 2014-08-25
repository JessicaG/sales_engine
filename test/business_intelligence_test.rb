require_relative 'test_helper'

class BusinessIntelligenceTest< Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_merchant_can_return_total_revenue_accross_all_transactions
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    assert_equal "24214.17", merchant.revenue.to_s('F')
  end

  def test_merchant_can_return_the_total_revenue_for_a_specific_date
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    assert_equal "21067.77", merchant.revenue_by_date("2012-03-25").to_s('F')
  end

  def test_merchant_returns_the_customer_who_has_conducted_the_most_successful_transactions
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    assert_equal "3", merchant.favorite_customer.id
  end

  def test_merchant_returns_customers_with_pending_invoices
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    assert_equal 3, merchant.customers_with_pending_invoices.count
  end

  def test_item_returns_the_date_with_the_most_sales_for_it_using_invoice_date
      item = engine.item_repository.items.detect do |item|
        item.id == "1"

      assert_equal "2012-03-25", item.best_day
  end


end
