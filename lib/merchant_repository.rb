require_relative 'repository_parser'

class MerchantRepository

  attr_reader :merchants

  def initialize(file = './data/merchants.csv')
    @merchants = RepositoryParser.load(file, class_name: Merchant)
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

end
