require_relative 'test_helper'

class BusinessIntelligenceTest< Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_most_revenue_x_returns_the_top_x_merchant_instances_ranked_by_total_revenue
  end

  def test_merchant_can_return_total_revenue_accross_all_transactions
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    assert_equal "21067.77", merchant.revenue.to_s('F')
  end

  def test_merchant_can_return_the_total_revenue_for_a_specific_date
    skip 
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    assert_equal "1000.00", merchant.revenue_by_date(2012-03-25)
  end



end
