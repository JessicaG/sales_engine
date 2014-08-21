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


end
