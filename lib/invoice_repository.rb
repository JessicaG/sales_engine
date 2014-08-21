require_relative 'invoice'
require_relative 'repository_parser'

class InvoiceRepository
  attr_reader :invoices

  def initialize(file = './test/fixtures/invoices.csv', engine)
    @invoices = create_invoices_from(file)
    @sales_engine = engine
  end

  def create_invoices_from(file)
    csv = RepositoryParser.load(file, class_name: Invoice)
    csv.collect { |row| Invoice.new(row, self) }
  end

  def inspect
     "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def random
    invoices.sample
  end

  def count
    invoices.count
  end

  def find_by(attribute, value)
    invoices.detect do |invoice|
      invoice.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_all_by(attribute, value)
    invoices.select do |invoice|
      invoice.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_by_status(value)
    find_by('status', value)
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_all_by_invoice_id(value)
    find_all_by('invoice_id', value)
  end

  def find_all_by_status(value)
    find_all_by('status', value)
  end

  def find_all_by_customer_id(value)
    find_all_by('customer_id', value)
  end

  def find_all_by_merchant_id(value)
    find_all_by('merchant_id', value)
  end

  def find_transactions_by_invoice_id(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

end
