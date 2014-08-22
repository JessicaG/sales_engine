require 'bigdecimal'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(data, repository)
    @id                  = data[:id]
    @name                = data[:name]
    @created_at          = data[:created_at]
    @updated_at          = data[:updated_at]
    @merchant_repository = repository
  end

  def items
    merchant_repository.find_items_by_merchant_id(id)
  end

  def invoices
    merchant_repository.find_invoices_by_merchant_id(id)
  end

  def revenue
    associated_invoice_items = invoices.map{|invoice| invoice.invoice_items}.reduce(:+)
    total_revenue = associated_invoice_items.reduce(0) {|sum, n| sum + (n.quantity.to_i * n.unit_price.to_i )}

    BigDecimal(total_revenue/100.00, 7)
    # total_revenue/100
  end


end
