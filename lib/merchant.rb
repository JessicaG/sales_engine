require 'bigdecimal'
require 'pry'
require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(data, repository)
    @id                  = data[:id].to_i
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

  def revenue(date= nil)
    if date.nil?
      revenues = successful_invoices(invoices).collect { |invoice| invoice.amount }
      revenue = revenues.reduce(:+)
    else
      invoices_for_date = successful_invoices(invoices).select { |invoice| invoice.created_at == date }
      revenues = invoices_for_date.collect{ |invoice| invoice.amount }
      revenue = revenues.reduce(:+)
    end
    if revenue == nil
      return 0
    else
      return revenue
    end
  end

  def customers
    customers = invoices.map(&:customer)
  end

  def favorite_customer
    grouped_customers = s_invoices.group_by {|customer| customer.id }.values
    grouped_customers.max_by(&:count).first
  end


  def successful_invoices(invoice_collection)
    invoice_collection.select {|invoice| invoice.transactions.any?{|transaction| transaction.result == "success"}}
  end

  def customers_with_pending_invoices
    failing_invoices = invoices.map {|invoice| invoice if invoice.successful_charge? == false }
    failing_invoices.select! { |invoice| invoice if invoice != nil }
    failing_invoices.map{|invoice| invoice.customer}
  end

  def amount_sold
    successful_items = successful_invoices(invoices).flat_map{|invoice| invoice.items}
    successful_items.count
  end

  private

  def s_invoices
    successful_invoices(self.invoices).map(&:customer)
  end

end
