require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test

def merchant_repository
  merchant_repository = MerchantRepository.new('./test/fixtures/merchants.csv')
end

def test_it_can_load_a_repository
  assert_equal 25, merchant_repository.merchants.length
end

def test_it_returns_basic_information
  information = merchant_repository.inspect
  assert_equal "#<MerchantRepository 25 rows>", information
end

def test_it_returns_a_random_customer
  random_merchant1 = merchant_repository.random
  random_merchant2 = merchant_repository.random

  refute random_merchant1 == random_merchant2
end

def test_it_can_return_all_merchants_in_the_repository
  assert_equal 25, merchant_repository.all.count
end

def test_it_can_find_merchants_by_name
  result = merchant_repository.find_by_name('Schroeder-Jerde')
  assert_equal 'Schroeder-Jerde', result.name
end

def test_it_can_find_merchants_by_id
  result = merchant_repository.find_by_id('1')
  assert_equal '1', result.id
end


end
