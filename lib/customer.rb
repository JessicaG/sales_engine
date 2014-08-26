# require 'pry'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repository

  def initialize(data, repository)
    @id                  = data[:id]
    @first_name          = data[:first_name]
    @last_name           = data[:last_name]
    @created_at          = data[:created_at]
    @updated_at          = data[:updated_at]
    @customer_repository = repository
  end

  # invoices returns a collection of Invoice instances associated with this object.
  def invoices
    customer_repository.find_invoices_by_customer_id(id)
  end

  #transactions returns an array of Transaction instances associated with the customer
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

  # def merchant_count
  #   paid_invoices.each_with_object(Hash.new(0))do |invoice, merchant_counts|
  #   merchant_counts[invoice.merchant_id] +=1
  #   end
  # end
  #
  # def top_merchant
  #   merchant_count.max_by { |_, count| count }[0]
  # end

  # def most_items(value)
  #   all.sort_by{ |item| item.quantity_sold }.reverse[0...value]
  # end
  #
  # def most_revenue(value)
  #   all.sort_by { |item| item.revenue }.reverse[0...value]
  # end

end
