require_relative 'customer'
require_relative 'repository_parser'

class CustomerRepository
  attr_reader :customers

  # def initialize(engine, csv_dir)
  #   @engine                = engine
  #   @customers             = RepositoryParser.load('./data/customers.csv', class_name: Customer)
  # end

  def initialize(file = './data/customers.csv')
    @customers = RepositoryParser.load(file, class_name: Customer)
  end

  def inspect
     "#<#{self.class} #{@customers.size} rows>"
  end

  def random
    customers.shuffle.pop
  end

  def count
    customers.count
  end


end
