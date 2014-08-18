require 'csv'
require_relative '../lib/customer_repository'

class SalesEngine
  attr_reader :customer_repository,
              :csv_dir

  def initialize(csv_dir='./test/fixtures')
    @csv_dir = csv_dir
  end

  def startup
    @customer_repository      = CustomerRepository.new(self, csv_dir)
  end

end
