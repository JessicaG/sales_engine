require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :invoice_items, :sales_engine

  def initialize(engine, invoice_item_attributes=[])
    @sales_engine  = engine
    @invoice_items = invoice_item_attributes.collect { |attributes| InvoiceItem.new(attributes, self) }
  end

  def inspect
     "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    @invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by(attribute, value)
    invoice_items.detect do |invoice_item|
      invoice_item.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_all_by(attribute, value)
    invoice_items.select do |invoice_item|
      invoice_item.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_by_item_id(value)
    find_by('item_id', value)
  end

  def find_all_by_quantity(value)
    find_all_by('quantity',value)
  end

  def find_all_by_invoice_id(value)
    find_all_by('invoice_id', value)
  end

  def find_invoice_by_invoice_item_id(id)
    sales_engine.find_invoice_by_invoice_item_id(id)
  end

  def find_item_by_item_id(id)
    sales_engine.find_item_by_item_id(id)
  end

end
