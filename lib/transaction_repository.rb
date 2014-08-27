require_relative 'transaction'

class TransactionRepository

  attr_reader :transactions, :sales_engine

  def initialize(engine,transaction_attributes=[])
    @sales_engine    = engine
    @transactions    = transaction_attributes.collect { |attributes| Transaction.new(attributes, self) }
  end

  def inspect
     "#<#{self.class} #{@transactions.size} rows>"
  end

  def count
    @transactions.count
  end

  def all
    @transactions
  end

  def random
    transactions.sample
  end

  def find_by(attribute, value)
    transactions.detect do |transaction|
      transaction.send(attribute) == value 
    end
  end

  def find_all_by(attribute, value)
    transactions.select do |transaction|
      transaction.send(attribute) == value
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

  def find_invoice_by_transaction_id(id)
    sales_engine.find_invoice_by_transaction_id(id)
  end

  def new_transacation(options, id)
    data = {id:                           count + 1,
            invoice_id:                   id,
            credit_card_number:           options[:credit_card_number],
            credit_card_expiration_date:  options[:credit_card_expiration],
            result:                       options[:result],
            created_at:                   Time.new.utc,
            updated_at:                   Time.new.utc,
           }
    transactions << Transaction.new(data, self)
  end
end
