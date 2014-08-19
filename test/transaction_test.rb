require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest< Minitest::Test

  def test_it_has_attributes
  data = {id: "123", invoice_id: "456", credit_card_number: "894567",
  credit_card_expiration_date: "05/07", result: "success", created_at:
  "10:52", updated_at: "11:25"}

  transaction = Transaction.new(data)

  assert_equal "123",     transaction.id
  assert_equal "456",     transaction.invoice_id
  assert_equal "894567",  transaction.credit_card_number
  assert_equal "05/07",   transaction.credit_card_expiration_date
  assert_equal "success", transaction.result
  assert_equal "10:52",   transaction.created_at
  assert_equal "11:25",   transaction.updated_at

  end
end
