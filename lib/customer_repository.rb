require_relative 'customer'          
require_relative 'repository_parser'                          # => true

class CustomerRepository
  attr_reader :customers  # => nil

  # def initialize(engine, csv_dir)
  #   @engine                = engine
  #   @customers             = RepositoryParser.load('./data/customers.csv', class_name: Customer)
  # end

  def initialize(file = './data/customers.csv')
    @customers = RepositoryParser.load(file, class_name: Customer)  # ~> NameError: uninitialized constant RepositoryParser::CSV
  end

  def inspect
     "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    @customers
  end

  def random
    customers.shuffle.pop
  end

  def count
    customers.count
  end


end

customer_repository = CustomerRepository.new
customer_repository.all

# ~> NameError
# ~> uninitialized constant RepositoryParser::CSV
# ~>
# ~> /Users/glenegbert/Dropbox/ruby_projects/sales_engine-1/lib/repository_parser.rb:10:in `load'
# ~> /Users/glenegbert/Dropbox/ruby_projects/sales_engine-1/lib/customer_repository.rb:14:in `initialize'
# ~> /Users/glenegbert/Dropbox/ruby_projects/sales_engine-1/lib/customer_repository.rb:36:in `new'
# ~> /Users/glenegbert/Dropbox/ruby_projects/sales_engine-1/lib/customer_repository.rb:36:in `<main>'
