require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest< Minitest::Test

  def test_it_has_attributes
  data = {id: "123", invoice_id: "456", credit_card_number: 894567 result: "success",  }
  transaction = Transaction.new(data)

  assert_equal "success", transaction.result

  end
end
