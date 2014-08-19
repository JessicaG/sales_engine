require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchants

  def setup
    @merchants = MerchantRepository.new('./test/fixtures/merchants.csv')
  end

  def test_it_returns_a_random_merchant
    merchant1 = merchants.random
    merchant2 = merchants.random
    assert merchant1 != merchant2
  end

end
