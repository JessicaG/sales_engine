require_relative 'test_helper'

class MerchantTest < Minitest::Test
  attr_reader :merchant, :repository

  def setup
    data = {id: 1, name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"}
    @repository = Minitest::Mock.new
    @merchant = Merchant.new(data, @repository)
  end

  def test_it_has_attributes
    assert_equal 1,                       merchant.id
    assert_equal "Schroeder-Jerde",         merchant.name
    assert_equal #<Date: 2012-03-27 ((2456014j,0s,0n),+0s,2299161j), merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_can_find_associated_items
    repository.expect(:find_items_by_merchant_id, [], [merchant.id])
    merchant.items
    repository.verify
  end
end
