require_relative 'test_helper'
require 'csv'

class CustomerRepositoryTest < Minitest::Test

  def repository
    engine = SalesEngine.new
    csv_dir='./test/fixtures'
    @repository ||= CustomerRepository.new(engine, csv_dir)
  end

  def test_it_has_more_than_five_customers
    assert repository.count > 5
  end

  def test_it_returns_a_random_customer
    random_customer = repository.random
    assert random_customer
  end

  def test_it_finds_single_customer_by_first_name
    result = repository.find_by_first_name('Joey')
    assert result.first_name, 'Joey'
  end

  def test_it_finds_a_single_id
    skip
    result = repository.find_by_id('1')
    assert '1', result.id
  end

  def test_it_can_find_all_by_last_name
    skip
    result = repository.find_all_by_last_name('Ondricka')
    assert 2, result.count
  end



end
