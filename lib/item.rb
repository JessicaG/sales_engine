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
    @id              = data[:id]
    @name            = data[:name]
    @description     = data[:description]
    @unit_price      = data[:unit_price]
    @merchant_id     = data[:merchant_id]
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
    item_repository.find_merchants_by_item_id(id)
  end

<<<<<<< HEAD
  def item
    associated_invoice_items = invoice_items
    associated_invoice_items.map{|invoice_item| [invoice_item.invoice.created_at, invoice_item.revenue}
    # find all invoice_items for item
    # map invoices_item to its date and revenue
    # select the date with the highest revenue and return its date
=======
  def revenue
    unit_price * amount_sold
  end

  def amount_sold
    invoice_items = paid_invoice_items
    invoice_items.collect(&:quantity).reduce(0, :+)
  end
  
  def paid_invoice_items
    invoice_items.find_all(&:successful?)
>>>>>>> d03e1ab51d324bc185d730c6a6b34e9c1e1b36db
  end

end
