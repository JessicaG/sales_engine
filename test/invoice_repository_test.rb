require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def repository
    rows = RepositoryParser.load('./test/fixtures/invoices.csv')
    repository = InvoiceRepository.new("engine", rows)
  end

  def test_it_can_load_other_items
    assert_equal 25, repository.invoices.length
  end

  def test_it_has_more_than_five_invoices
    assert repository.count > 5
  end

  def test_it_returns_a_random_invoice
      random_invoice1 = repository.random
      random_invoice2 = repository.random

      refute random_invoice1 == random_invoice2
  end

  def test_it_finds_a_single_invoice_by_id
    result = repository.find_by_id(1)
    assert result.id, 1
  end

  def test_it_finds_mulitple_invoices_by_customer_id
    result = repository.find_all_by_customer_id(3)
    assert_equal 4, result.count
  end

  def test_it_can_find_by_status
    result = repository.find_by_status('shipped')
    assert "shipped", result.status
  end

  def test_it_can_find_all_by_status
    result = repository.find_all_by_status('shipped')
    assert 25, result.count
  end

  def test_it_can_find_all_by_merchant_id
    result = repository.find_all_by_merchant_id(2)
    assert 10, result.count
  end

end
