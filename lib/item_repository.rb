require_relative 'item'
# require_relative 'repository_parser'

class ItemRepository

  attr_reader :items, :sales_engine

  def initialize(engine, item_attributes=[])
    @sales_engine = engine
    @items        = item_attributes.collect { |attributes| Item.new(attributes, self) }
  end

  def inspect
     "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def random
    items.sample
  end

  def find_by(attribute, value)
    items.detect do |item|
      item.send(attribute) == value
    end
  end

  def find_all_by(attribute, value)
    items.select do |item|
      item.send(attribute) == value
    end
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_by_name(value)
    find_by('name', value)
  end

  def find_all_by_merchant_id(value)
    find_all_by('merchant_id',value)
  end

  def find_all_by_name(value)
    find_all_by('name', value)
  end

  def find_by_unit_price(value)
    find_by('unit_price', value)
  end

  def find_invoice_items_by_item_id(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_merchant_id(id)
    sales_engine.find_merchant_by_merchant_id(id)
  end

  def most_revenue(value)
    all.sort_by { |item| item.revenue }.reverse[0...value]
  end

  def most_items(value)
    all.sort_by { |item| item.amount_sold }.reverse[0...value]
  end

end
