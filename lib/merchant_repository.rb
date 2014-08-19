require_relative 'repository_parser'
require_relative 'merchant'

class MerchantRepository

  def initialize(file = './test/fixtures/customers.csv')
    @customers = RepositoryParser.load(file, class_name: Customer)
  end

  def inspect
     "#<#{self.class} #{@merchants.size} rows>"
  end

  def random
    merchants.shuffle.sample
  end

  def count
    merchants.count
  end

end
