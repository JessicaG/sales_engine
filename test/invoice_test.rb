require_relative 'test_helper'

class InvoiceTest< Minitest::Test

  def test_it_has_attributes
  data = {id: "123", customer_id: "456", merchant_id: "894567",
  created_at: "10:52", updated_at: "11:25"}

  invoice = Invoice.new(data, self)

  assert_equal "123",     invoice.id
  assert_equal "456",     invoice.customer_id
  assert_equal "894567",  invoice.merchant_id
  assert_equal "10:52",   invoice.created_at
  assert_equal "11:25",   invoice.updated_at

  end
end
