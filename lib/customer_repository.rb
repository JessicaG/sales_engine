require_relative 'customer'
require_relative 'repository_parser'

class CustomerRepository
  # include RepositoryParser

  attr_reader :engine,
              :customers

  def initialize(engine, csv_dir)
    @engine                = engine
    @customers             = RepositoryParser.load('./data/customers.csv', class_name: Customer)
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
