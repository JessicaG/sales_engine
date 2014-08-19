require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_loads_items_by_default
    invoice_repository = InvoiceRepository.new

    assert_equal 4843, invoice_repository.invoices.length
  end

  def test_it_can_load_other_items
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    assert_equal 25, invoice_repository.invoices.length
  end
end
