require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test

  def test_it_loads_items_by_default
    merchant_repository = MerchantRepository.new

    assert_equal 100, merchant_repository.merchants.length
  end

  def test_it_can_load_other_items
    merchant_repository = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_equal 25, merchant_repository.merchants.length
  end
end
