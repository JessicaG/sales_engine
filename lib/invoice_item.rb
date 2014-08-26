class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :invoice_item_repository

  def initialize(data, repository)
    @id                      = data[:id]
    @item_id                 = data[:item_id]
    @invoice_id              = data[:invoice_id]
    @quantity                = data[:quantity]
    @unit_price              = data[:unit_price]
    @created_at              = data[:created_at]
    @updated_at              = data[:updated_at]
    @invoice_item_repository = repository
  end

# invoice returns an instance of Invoice associated with this object
# item returns an instance of Item associated with this object

  def invoice
    invoice_item_repository.find_invoice_by_invoice_id(invoice_id)
  end

  def item
    invoice_item_repository.find_item_by_item_id(item_id)
  end

  def total_price
    unit_price.to_i * quantity.to_i
  end

  def successful?
    invoice.successful_charge?
  end
end
