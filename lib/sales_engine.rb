require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :customer_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :item_repository,
              :transaction_repository

  def startup
    @merchant_repository      = MerchantRepository.new(self)
    @customer_repository      = CustomerRepository.new(self)
    @invoice_repository       = InvoiceRepository.new(self)
    @invoice_item_repository  = InvoiceItemRepository.new(self)
    @item_repository          = ItemRepository.new(self)
    @transaction_repository   = TransactionRepository.new(self)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end 

end
