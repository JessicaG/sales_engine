require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_loads_transactions_by_default
    transaction_repository = TransactionRepository.new

    assert_equal 5595, transaction_repository.transactions.length
  end

  def test_it_can_load_other_transactions
    transaction_repository = TransactionRepository.new('./test/fixtures/transactions.csv')

    assert_equal 25, transaction_repository.transactions.length
  end
end
