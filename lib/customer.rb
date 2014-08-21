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
end
