require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test

  def transaction_repository
    rows = RepositoryParser.load('./test/fixtures/transactions.csv')
    transaction_repository = TransactionRepository.new('engine',rows)
  end

  def test_it_can_load_a_repository
    assert_equal 25, transaction_repository.transactions.length
  end

  def test_it_returns_basic_information
    information = transaction_repository.inspect
    assert_equal "#<TransactionRepository 25 rows>", information
  end

  def test_it_returns_a_random_customer
    random_transaction1 = transaction_repository.random
    random_transaction2 = transaction_repository.random

    refute random_transaction1 == random_transaction2
  end

  def test_it_can_return_all_transactions_in_the_repository
    assert_equal 25, transaction_repository.all.count
  end

  # def test_it_can_find_transactions_by_name
  #   result = transaction_repository.find_by_name('Schroeder-Jerde')
  #   assert_equal 'Schroeder-Jerde', result.name
  # end
  #
  def test_it_can_find_transactions_by_id
    result = transaction_repository.find_by_id('1')
    assert_equal '1', result.id
  end

  def test_it_can_find_transactions_by_credit_card_number
    result = transaction_repository.find_by_credit_card_number('4654405418249632')
    assert_equal '4654405418249632', result.credit_card_number
  end

  def test_it_can_find_all_transactions_with_a_specified_result
    result = transaction_repository.find_all_by_result('failed')
    assert_equal 5, result.count
  end
end
