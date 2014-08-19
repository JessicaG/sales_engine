require_relative 'test_helper'

class CustomerTest< Minitest::Test

  def test_it_has_attributes
  data = {id: "123", first_name: "456", last_name: "894567",
  created_at: "10:52", updated_at: "11:25"}

  customer = Customer.new(data)

  assert_equal "123",     customer.id
  assert_equal "456",     customer.first_name
  assert_equal "894567",  customer.last_name
  assert_equal "10:52",   customer.created_at
  assert_equal "11:25",   customer.updated_at

  end
end
