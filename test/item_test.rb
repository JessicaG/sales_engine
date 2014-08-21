require_relative 'test_helper'

class ItemTest< Minitest::Test

  def test_it_has_attributes
  data = {id: "123", name: "toy", description: "plush",
  unit_price: "$1.57", merchant_id: "success",
  created_at: "10:52", updated_at: "11:25"}

  item = Item.new(data, self)

  assert_equal "123",     item.id
  assert_equal "toy",     item.name
  assert_equal "plush",   item.description
  assert_equal "$1.57",   item.unit_price
  assert_equal "success", item.merchant_id
  assert_equal "10:52",   item.created_at
  assert_equal "11:25",   item.updated_at

  end
end
