require 'pry'
class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repository

  def initialize(data, repository)
    @id                  = data[:id].to_i
    @first_name          = data[:first_name]
    @last_name           = data[:last_name]
    @created_at          = data[:created_at]
    @updated_at          = data[:updated_at]
    @customer_repository = repository
  end

  def invoices
    customer_repository.find_invoices_by_customer_id(id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end

  def favorite_merchant
    grouped_merchants =
    successful_merchants.group_by { |merchant| merchant.id }.values
    grouped_merchants.max_by(&:count).first
  end

  def successful_invoices
    invoices.select { |invoice| invoice.transactions.any?{ |transaction| transaction.result == "success" } }
  end

  private

  def successful_merchants
    successful_invoices.map(&:merchant).compact
  end

end
