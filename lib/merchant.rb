class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  # def items
  #   merchant_repo.find_orders_by_merchant_id(id)
  # end

end
