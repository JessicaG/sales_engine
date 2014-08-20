require_relative 'repository_parser'

class TransactionRepository

  attr_reader :transactions

  def initialize(file = './data/transactions.csv')
    @transactions = RepositoryParser.load(file, class_name: Transaction)
  end

  ##Methods for all, inspect, random
  ##find by, find all by
  ##find_by id, find_by credit card number, find all by result
end
