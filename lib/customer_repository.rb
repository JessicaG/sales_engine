class CustomerRepository

  def initialize(engine, csv_dir)
    @customer_repository ||= CSV.open(csv_dir + '/customers.csv',
    headers: true, header_converters: :symbol)
    build_records(@customer_repository)
  end

  def build_records(repository)
    @customers = repository.map { |row| Customer.new(row, self) }
  end

end
