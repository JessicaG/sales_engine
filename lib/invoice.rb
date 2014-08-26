class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at,
              :updated_at,
              :status,
              :invoice_repository


  def initialize(data, repository)
    @id                 = data[:id]
    @customer_id        = data[:customer_id]
    @merchant_id        = data[:merchant_id]
    @created_at         = data[:created_at]
    @updated_at         = data[:updated_at]
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
end
