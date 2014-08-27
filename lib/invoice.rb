require 'date'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at,
              :updated_at,
              :status,
              :invoice_repository


  def initialize(data, repository)
    @id                 = data[:id].to_i
    @customer_id        = data[:customer_id].to_i
    @merchant_id        = data[:merchant_id].to_i
    @created_at         = Date.parse(data[:created_at])
    @updated_at         = Date.parse(data[:updated_at])
    @status             = data[:status]
    @invoice_repository = repository
  end

  def transactions
    invoice_repository.find_transactions_by_invoice_id(id)
  end

  def invoice_items
    invoice_repository.find_invoice_items_by_invoice_id(id)
  end

  def items
    invoice_repository.find_items_by_invoice_id(id)
  end

  def customer
    invoice_repository.find_customer_by_customer_id(customer_id)
  end

  def merchant
    invoice_repository.find_merchant_by_merchant_id(merchant_id)
  end

  def successful_charge?
    transactions.any?(&:successful?)
  end

  def amount
    invoice_items.map(&:total_price).reduce(0, :+)
  end

  def charge(options = {})
    invoice_repository.new_transacation(options, id)
  end

end
