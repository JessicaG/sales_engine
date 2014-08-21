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
end
