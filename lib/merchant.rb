require 'bigdecimal'
require 'pry'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(data, repository)
    @id                  = data[:id]
    @name                = data[:name]
    @created_at          = Date.parse(data[:updated_at])
    @updated_at          = Date.parse(data[:created_at])
    @merchant_repository = repository
  end

  def items
    merchant_repository.find_items_by_merchant_id(id)
  end

  def invoices
    merchant_repository.find_invoices_by_merchant_id(id)
  end

  def revenue
    successfully_transacted_invoices = invoices.select {|invoice| invoice.transactions.any?{|transaction| transaction.result == "success"}}
    associated_invoice_items = successfully_transacted_invoices.map{|invoice| invoice.invoice_items}.reduce(:+)
    total_revenue = associated_invoice_items.reduce(0) {|sum, n| sum + (n.quantity.to_i * n.unit_price.to_i )}

    BigDecimal(total_revenue/100.00, 7)
  end

  def revenue_by_date(date)
    invoices_from_date = invoices.select {|invoice| invoice.created_at[0..9] == date}
    successfully_transacted_invoices_by_date = invoices_from_date.select {|invoice| invoice.transactions.any?{|transaction| transaction.result == "success"}}
    invoice_items_from_date = successfully_transacted_invoices_by_date.map{|invoice| invoice.invoice_items}.reduce(:+)
    total_revenue_for_date = invoice_items_from_date.reduce(0) {|sum, n| sum + (n.quantity.to_i * n.unit_price.to_i )}

    BigDecimal(total_revenue_for_date/100.00, 7)
  end

<<<<<<< HEAD
  def customers
    invoices.collect{|invoice| invoice.customer}
  end

  def favorite_customer
    repository.engine.customer_repository.find_by_id(top_customer)
  end

  def customer_count
    paid_invoices.each_with_object(Hash.new(0))do |invoice, counts|
    counts[invoice.customer_id] +=1
    end
  end

  def amount_sold
    invoices = paid_invoices
    invoices.collect(&:quantity).reduce(0, :+)
  end

  def unpaid_invoices
    invoices.select{ |invoice| invoice.unpaid? }
  end

  def customers_with_pending_invoices
    unpaid_invoices.collect{|invoice| invoice.customer}.uniq
  end

  def top_customer
    customer_count.max_by { |_, count| count }[0]
  end

=======
  def favorite_customer
  successful_invoices = invoices.select {|invoice| invoice.transactions.any?{|transaction| transaction.result == "success"}}
  customer_count = successful_invoices.map{|s_invoice| successful_invoices.count{|invoice| invoice.customer_id == s_invoice.customer_id}}
  invoices_and_customer_count = successful_invoices.zip(customer_count)
  favorite_customer_invoice = invoices_and_customer_count.max_by{|invoice_count| invoice_count[1]}[0]
  favorite_customer_invoice.customer
  end

  def customers_with_pending_invoices
    failing_invoices = invoices.select {|invoice| invoice.transactions.any?{|transaction| transaction.result == "success"} == false}
    failing_invoices.map{|invoice| invoice.customer}
  end
>>>>>>> a59d7430d02415ea4f228f45bdb1e9032bff833a

end
