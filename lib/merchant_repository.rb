require_relative 'repository_parser'

class MerchantRepository

  attr_reader :merchants, :sales_engine

  def initialize(file = './test/fixtures/merchants.csv', engine)
    @merchants = create_merchants_from(file)
    @sales_engine = engine
  end

  #
  def create_merchants_from(file)
    csv = RepositoryParser.load(file, class_name: Merchant)
    csv.collect { |row| Merchant.new(row, self) }
  end
  #

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
      merchant.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_all_by(attribute, value)
    merchants.select do |merchant|
      merchant.send(attribute) =~ /^#{value}$/i
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

end
