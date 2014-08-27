class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repository

  def initialize(data, repository)
    @id                  = data[:id].to_i
    @first_name          = data[:first_name]
    @last_name           = data[:last_name]
    @created_at          = data[:created_at]
    @updated_at          = data[:updated_at]
    @customer_repository = repository
  end

  def invoices
    customer_repository.find_invoices_by_customer_id(id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end

  def favorite_merchant
    merchant_count = successful_invoices.map{|s_invoice| successful_invoices.count{|invoice| invoice.merchant_id == s_invoice.merchant_id}}
    invoices_and_merchant_count = successful_invoices.zip(merchant_count)
    favorite_invoice = invoices_and_merchant_count.max_by{|invoice_count| invoice_count[1]}[0]
    favorite_invoice.merchant
  end

  def successful_invoices
    invoices.select {|invoice| invoice.transactions.any?{|transaction| transaction.result == "success"}}
  end
end
