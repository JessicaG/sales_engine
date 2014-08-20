require_relative 'repository_parser'

class TransactionRepository

  attr_reader :transactions

  def initialize(file = './data/transactions.csv')
    @transactions = RepositoryParser.load(file, class_name: Transaction)
  end

  def inspect
     "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    @transactions
  end

  def random
    transactions.sample
  end

  def find_by(attribute, value)
    transactions.detect do |transaction|
      transaction.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_all_by(attribute, value)
    transactions.select do |transaction|
      transaction.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_by_credit_card_number(value)
    find_by('credit_card_number', value)
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_all_by_result(value)
    find_all_by('result',value)
  end

end
