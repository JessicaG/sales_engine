require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def data
    {id: "1", name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"}
  end

  def test_it_has_attributes

    merchants = Merchant.new(data)
    assert_equal "1",                       merchants.id
    assert_equal "Schroeder-Jerde",         merchants.name
    assert_equal "2012-03-27 14:53:59 UTC", merchants.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchants.updated_at
  end

  def test_it_can_find_associated_items
    
  end
end
