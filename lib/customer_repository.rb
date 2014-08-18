require_relative 'customer'

class CustomerRepository
  attr_reader :engine,
              :customers

  def initialize(engine, csv_dir)
    @engine                = engine
    @customers             = []
    @customer_repository ||= CSV.open(csv_dir + '/customers.csv',
    headers: true, header_converters: :symbol)
    build_records(@customer_repository)
  end

  def build_records(repository)
    @customers = repository.map { |row| Customer.new(row, self) }
  end

  def inspect
     "#<#{self.class} #{@customers.size} rows>"
  end

  def random
    customers.shuffle.pop
  end


end
