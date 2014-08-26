require_relative 'test_helper'
# require 'pry'

class BusinessIntelligenceTest< Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

# **********MERCHANT REPOSITORY BUSINESS INTELLIGENCE*************
  def test_merchant_repo_can_return_the_top_x_merchants_by_total_revenue
    merchant_repository = engine.merchant_repository

    assert_equal 8, merchant_repository.most_revenue(8).count
    assert_equal "18", merchant_repository.most_revenue(3).first.id
  end

  def test_merchant_repo_can_return_the_top_x_merchants_by_total_number_of_items
    merchant_repository = engine.merchant_repository

    assert_equal 8, merchant_repository.most_items(8).count
    assert_equal "1", merchant_repository.most_items(3).first.id
  end

  def test_merchant_repo_can_return_the_total_revenue_by_date
    merchant_repository = engine.merchant_repository

    assert_equal "21067.77", merchant_repository.revenue("2012-03-25").to_s('F')
    # assert_equal 8, merchant_repository.revenue("2012-03-25")
    # assert_equal "1", merchant_repository.revenue(date)(3).first.id
  end


# ***********MERCHANT BUSINESS INTELLIGENCE***********

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

    favorite_customer = merchant.favorite_customer
  end

  def test_merchant_returns_customers_with_pending_invoices
    merchant = engine.merchant_repository.merchants.detect do |merchant|
      merchant.id == "1"
    end

    assert_equal 3, merchant.customers_with_pending_invoices.count
  end

# ***********ITEM BUSINESS INTELLIGENCE ******************
  def test_item_returns_the_date_with_the_most_sales_for_it_using_invoice_date
      item = engine.item_repository.items.detect do |item|
        item.id == "1"
      end

      assert_equal "2012-03-10", item.best_day
  end


# ***********CUSTOMER BUSINESS INTELLIGENCE **************

  def test_customer_can_return_associated_customer_transactions
    customer = engine.customer_repository.find_by('id', 1)
    associated_transactions = customer.transactions
    assert_equal 8, associated_transactions.count
    assert_equal [1,2,3,4,5,6,7,20].map(&:to_s), associated_transactions.map(&:id)
  end

  def test_customer_can_return_the_merchant_where_it_has_the_most_successful_transactions
    customer = engine.customer_repository.find_by('id', 1)
    assert_equal "38", customer.favorite_merchant.id
  end

  # ****************ITEM REPOSITORY TEST *********************
  def test_item_repository_can_return_the_top_x_items_ranked_by_revenue
    item_repository = engine.item_repository

    assert_equal 10, item_repository.most_revenue(10).count
    assert_equal "1", item_repository.most_revenue(10).first.id
  end

  def test_item_repository_can_return_the_top_x_items_ranked_by_total_number_sold
    item_repository = engine.item_repository

    assert_equal 10, item_repository.most_items(10).count
    assert_equal "1", item_repository.most_items(10).first.id
  end

  # def test_favorite_merchant_can_return_associated_customer_instances
  #   skip
  #   customer = engine.customer_repository.find_by('id', 1)
  #   assert_equal 'Shroeder-Jerde', favorite_merchant
  #
  #   assert_equal "3", merchant.favorite_customer.id
  # end

  # def test_it_can_return_customers_with_pending_invoices
  #   skip
  #   merchant = engine.merchant_repository.find_by('id', 10)
  #   assert_equal 'Mariah', merchant.customers_with_pending_invoices.first.first_name
  # end

  # def test_it_can_return_customer_with_most_successful_transactions_for_merchants
  #   skip
  #   merchant = engine.merchant_repository.find_by('id', 1)
  #   assert_equal 'Joey', merchant.favorite_customer.first.first_name
  # end


end
