require 'bigdecimal'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(data, repository)
    @id                  = data[:id].to_i
    @name                = data[:name]
    @created_at          = data[:updated_at]
    @updated_at          = data[:created_at]
    @merchant_repository = repository
  end

  def items
    merchant_repository.find_items_by_merchant_id(id)
  end

  def invoices
    merchant_repository.find_invoices_by_merchant_id(id)
  end

  def revenue
    associated_invoice_items = successful_invoices(invoices).flat_map{|invoice| invoice.invoice_items}
    total_revenue = associated_invoice_items.reduce(0) {|sum, invoice_item| sum + (invoice_item.quantity.to_i * invoice_item.unit_price.to_i )}

    BigDecimal(total_revenue/100.00, 7)
  end

  ##refactor for revenue && revenue(date) into one method

  def revenue_by_date(date)
    invoices_from_date = invoices.select {|invoice| invoice.created_at[0..9] == date}
    invoice_items_from_date = successful_invoices(invoices_from_date).flat_map{|invoice| invoice.invoice_items}
    total_revenue_for_date = invoice_items_from_date.reduce(0) {|sum, n| sum + (n.quantity.to_i * n.unit_price.to_i )}
    BigDecimal(total_revenue_for_date/100.00, 7)
  end

  def customers
    customers = invoices.map(&:customer)
  end

  def favorite_customer
    invoices = successful_invoices(self.invoices)
    customer_count = invoices.map{|s_invoice| invoices.count{|invoice| invoice.customer_id == s_invoice.customer_id}}
    invoices_and_customer_count = invoices.zip(customer_count)
    favorite_customer_invoice = invoices_and_customer_count.max_by{|invoice_count| invoice_count[1]}[0]
    favorite_customer_invoice.customer
  end

  def successful_invoices(invoice_collection)
    invoice_collection.select {|invoice| invoice.transactions.any?{|transaction| transaction.result == "success"}}
  end

  def customers_with_pending_invoices
    failing_invoices = invoices.select {|invoice| invoice.transactions.any?{|transaction| transaction.result != "success"}}
    failing_invoices.map{|invoice| invoice.customer}
  end

  def amount_sold
    successful_items = successful_invoices(invoices).flat_map{|invoice| invoice.items}
    successful_items.count
  end

end
