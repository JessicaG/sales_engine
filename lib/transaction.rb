class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repository

  def initialize(data, repository)
    @id                          = data[:id]
    @invoice_id                  = data[:invoice_id]
    @credit_card_number          = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result                      = data[:result]
    @created_at                  = data[:created_at]
    @updated_at                  = data[:updated_at]
    @transaction_repository      = repository
  end

  # invoice returns an instance of Invoice associated with this object
  def invoice
    transaction_repository.find_invoice_by_transaction_id(invoice_id)
  end

end
