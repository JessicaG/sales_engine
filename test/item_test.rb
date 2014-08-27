require_relative 'test_helper'

class ItemTest< Minitest::Test

  def test_it_has_attributes
  data = {id: 123, name: "toy", description: "plush",
  unit_price: "75107", merchant_id: "1",
  created_at: "10:52", updated_at: "11:25"}

  item = Item.new(data, self)

  assert_equal 123,     item.id
  assert_equal "toy",     item.name
  assert_equal "plush",   item.description
  assert_equal BigDecimal.new(75107).to_i/100,   item.unit_price.to_i
  assert_equal 1, item.merchant_id
  assert_equal "10:52",   item.created_at
  assert_equal "11:25",   item.updated_at

  end
end
