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



end
