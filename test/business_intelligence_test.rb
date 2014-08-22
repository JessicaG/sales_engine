require_relative 'test_helper'

class BusinessIntelligenceTest< Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_most_revenue_x_returns_the_top_x_merchant_instances_ranked_by_total_revenue


      most_revenue(x)
        merchant_repo.sort_by > thru > invoice_items.unit_price
      .first(x)
  end

end
