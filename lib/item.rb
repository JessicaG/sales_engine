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

  def invoice_items
    item_repository.find_invoice_items_by_item_id(id)
  end

  def merchant
    item_repository.find_merchant_by_merchant_id(merchant_id)
  end

  def best_day
    invoices = invoice_items.map { |invoice_item| invoice_item.invoice }
    best_invoice =
    invoices.max_by do |invoice|
        invoices.each do |i|
          if invoice.id == i.id
            invoice.amount + i.amount
          else
            invoice.amount
          end
        end
      end
    best_invoice.created_at
  end



  def revenue
    unit_price * amount_sold
  end

  def amount_sold
    invoice_items = paid_invoice_items
    invoice_items.collect{|invoice_item| invoice_item.quantity.to_i}.reduce(0, :+)
  end

  def paid_invoice_items
    invoice_items.find_all(&:successful?)
  end

end
