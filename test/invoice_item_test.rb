require_relative 'test_helper'

class InvoiceItemTest< Minitest::Test

  def test_it_has_attributes
  data = {id: "123", item_id: "456", invoice_id: "894567", quantity:
  "10", unit_price: "75107",  created_at: "10:52", updated_at: "11:25"}

  invoice_items = InvoiceItem.new(data, self)

  assert_equal 123,     invoice_items.id
  assert_equal 456,     invoice_items.item_id
  assert_equal 894567,  invoice_items.invoice_id
  assert_equal 10,      invoice_items.quantity
  assert_equal BigDecimal.new(75107).to_i/100,   invoice_items.unit_price.to_i
  assert_equal "10:52",   invoice_items.created_at
  assert_equal "11:25",   invoice_items.updated_at

  end
end
