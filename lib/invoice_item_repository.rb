require_relative 'repository_parser'

class InvoiceItemRepository

  attr_reader :invoice_items

  def initialize(file = './data/invoice_items.csv')
    @invoice_items = RepositoryParser.load(file, class_name: Invoice_item)
  end
end
