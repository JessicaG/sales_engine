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

  def count
    invoice_items.count
  end

  def find_by(attribute, value)
    invoice_items.detect do |invoice_item|
      invoice_item.send(attribute) == value
    end
  end

  def find_all_by(attribute, value)
    invoice_items.select do |invoice_item|
      invoice_item.send(attribute) == value
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

  def find_invoice_by_invoice_id(id)
    sales_engine.find_invoice_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    sales_engine.find_item_by_item_id(id)
  end

  def new_invoice_items(options, invoice_id)
    grouped_items = options[:items].group_by {|item| item}
    items_and_counts_array =
    grouped_items.each_pair.map{|key, value| [key, value.count]}

    items_and_counts_array.each do |item_count|
          data = {id:               count + 1,
                  item_id:          item_count[0].id,
                  invoice_id:       invoice_id,
                  quantity:         item_count[1],
                  unit_price:       item_count[0].unit_price,
                  created_at:       Time.new.utc,
                  updated_at:       Time.new.utc,
                  }
            invoice_items << InvoiceItem.new(data, self)
    end
  end

end
