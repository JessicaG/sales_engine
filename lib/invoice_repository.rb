require_relative 'invoice'
require_relative 'repository_parser'

class InvoiceRepository
  attr_reader :invoices

  def initialize(file = './data/invoices.csv')
    @invoices = RepositoryParser.load(file, class_name: Invoice)
  end
end
