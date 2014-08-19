require_relative 'repository_parser'

class TransactionRepository

  attr_reader :transactions

  def initialize(file = './data/transactions.csv')
    @transactions = RepositoryParser.load(file, class_name: Transaction)
  end
end
