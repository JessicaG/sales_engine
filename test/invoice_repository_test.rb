require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def repository
    repository = InvoiceRepository.new('./test/fixtures/invoices.csv')
  end

  # def test_it_loads_items_by_default
  #   invoice_repository = InvoiceRepository.new
  #
  #   assert_equal 4843, invoice_repository.invoices.length
  # end

  def test_it_can_load_other_items
    assert_equal 25, repository.invoices.length
  end

  def test_it_has_more_than_five_invoices
    assert repository.count > 5
  end

  def test_it_returns_a_random_invoice
    random_invoice = repository.random
    assert random_invoice
  end

  def test_it_finds_a_single_invoice_by_id
    result = repository.find_by_id('1')
    assert result.id, '1'
  end

  def test_it_finds_mulitple_invoice_by_id
    skip
    result = repository.find_all_by_id('2')
    assert '2', result.id
  end

  def test_it_can_find_by_status
    skip
    result = repository.find_by_status('shipped')
    assert 1, result.count
  end

  def test_it_can_find_all_by_status
    skip
    result = repository.find_all_by_status('shipped')
    assert 25, result.count
  end

  def test_it_responds_to_is_true_if_there_is_a_valid_attribute
    invoice_data = {id: '1', customer_id: '8', merchant_id: '38' }
    invoice = Invoice.new(invoice_data)
    assert invoice.respond_to?('id')
    assert invoice.respond_to?('customer_id')
  end

  def test_it_does_not_respond_if_there_is_not_a_valid_attribute
    invoice_data = {id: '1', customer_id: '8', merchant_id: '38' }
    invoice = Invoice.new(invoice_data)
    refute invoice.respond_to?('invoice_id')
    refute invoice.respond_to?('name')
  end

end
