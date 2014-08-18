require_relative 'test_helper'
require 'csv'

class CustomerRepositoryTest < Minitest::Test

  def repository
    csv_dir='./test/fixtures'
    @repository ||= CustomerRepository.new(self, csv_dir)
  end

  
end
