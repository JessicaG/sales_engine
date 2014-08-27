require_relative 'merchant'

class MerchantRepository

  attr_reader :merchants, :sales_engine

  def initialize(engine, merchants_attributes=[])
    @sales_engine = engine
    @merchants    = merchants_attributes.collect { |attributes| Merchant.new(attributes, self) }
  end

  def inspect
     "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def random
    merchants.sample
  end

  def find_by(attribute, value)
    merchants.detect do |merchant|
      merchant.send(attribute) == value
    end
  end

  def find_all_by(attribute, value)
    merchants.select do |merchant|
      merchant.send(attribute) == value
    end
  end

  def find_by_name(value)
    find_by('name', value)
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_items_by_merchant_id(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def most_revenue(value)
    all.sort_by { |merchant| merchant.revenue }.reverse[0...value]
  end

  def revenue(date)
    # binding.pry
    merchants.map { |merchant| merchant.revenue_by_date(date) }.reduce(0, :+)
  end

  def most_items(value)
    all.sort_by { |merchant| merchant.amount_sold }.reverse[0...value]
  end

end
