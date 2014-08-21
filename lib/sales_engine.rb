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
              # :csv_dir
  # def initialize(csv_dir='./test/fixtures')
  #   @csv_dir = csv_dir
  # end

  def startup
    @merchant_repository      = MerchantRepository.new(self)
    @customer_repository      = CustomerRepository.new
    @invoice_repository       = InvoiceRepository.new
    @invoice_item_repository  = InvoiceItemRepository.new
    @item_repository          = ItemRepository.new(self)
    @transaction_repository   = TransactionRepository.new
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

end
