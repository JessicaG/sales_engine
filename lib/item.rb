require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :item_repository

  def initialize(data, repository)
    @id              = data[:id].to_i
    @name            = data[:name]
    @description     = data[:description]
    @unit_price      = BigDecimal.new((data[:unit_price].to_f/100.00).to_s)
    @merchant_id     = data[:merchant_id].to_i
    @created_at      = data[:created_at]
    @updated_at      = data[:updated_at]
    @item_repository = repository
  end

# invoice_items returns a collection of InvoiceItems associated with this object
  def invoice_items
    item_repository.find_invoice_items_by_item_id(id)
  end
# merchant returns an instance of Merchant associated with this object
  def merchant
    item_repository.find_merchant_by_merchant_id(merchant_id)
  end

  def best_day
    invoice_item_dates_revenues = invoice_items.map{|invoice_item| [invoice_item.invoice.created_at, invoice_item.total_price]}
    invoice_item_revenues_grouped_by_date = invoice_item_dates_revenues.group_by{|date_revenue| date_revenue[0]}
    combined_date_revenue_array = invoice_item_revenues_grouped_by_date.each_pair.map{|key, value| [key, value.reduce(0){|sum, ary| sum + ary[1]}]}
    best_date = combined_date_revenue_array.sort_by{|ary| ary[1]}[-1][0][0..9]
  end

  def revenue
    unit_price.to_i * amount_sold
  end

  def amount_sold
    invoice_items = paid_invoice_items
    invoice_items.collect{|invoice_item| invoice_item.quantity.to_i}.reduce(0, :+)
  end

  def paid_invoice_items
     invoice_items.find_all(&:successful?)
  end

end
