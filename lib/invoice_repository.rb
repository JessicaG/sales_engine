require_relative 'invoice'
require_relative 'repository_parser'

class InvoiceRepository
  attr_reader :invoices

  def initialize(file = './data/invoices.csv')
    @invoices = RepositoryParser.load(file, class_name: Invoice)
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

  def find_all_by_customer_id(value)
    find_all_by('customer_id', value)
  end

  def find_all_by_status(value)
    find_all_by('status', value)
  end

end
