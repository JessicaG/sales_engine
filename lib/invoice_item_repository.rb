require_relative 'repository_parser'

class InvoiceItemRepository

  attr_reader :items

  def initialize(file = './data/invoice_items.csv')
    @items = RepositoryParser.load(file, class_name: Item)
  end
end
