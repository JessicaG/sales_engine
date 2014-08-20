require_relative 'repository_parser'

class InvoiceItemRepository

  attr_reader :invoice_items

  def initialize(file = './data/invoice_items.csv')
    @invoice_items = RepositoryParser.load(file, class_name: Invoice_item)
  end

  ##Methods needed for random, inspect, all
  ##find by, find all by, find by id,
  ##find by item id, find all by quantity
end
