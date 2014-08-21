require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/item_repository'
require_relative '../lib/repository_parser'

class SalesEngine
  attr_reader :customer_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :item_repository,
              :transaction_repository,
              :directory

  def initialize(directory = './test/fixtures')
    @directory = directory
  end

  def load_repositories
   @merchant_rows = RepositoryParser.load(@directory + '/merchants.csv')
   @customer_rows = RepositoryParser.load(@directory + '/customers.csv')
   @invoice_rows = RepositoryParser.load(@directory + '/invoices.csv')
   @invoice_item_rows = RepositoryParser.load(@directory + '/invoice_items.csv')
   @item_rows = RepositoryParser.load(@directory + '/items.csv')
   @transaction_rows = RepositoryParser.load(@directory + '/transactions.csv')
  end

  def startup
    # rows = RepositoryParser.load(@directory + '/merchants.csv')
    load_repositories
    @merchant_repository      = MerchantRepository.new(self, @merchant_rows)
    @customer_repository      = CustomerRepository.new(self, @customer_rows)
    @invoice_repository       = InvoiceRepository.new(self, @invoice_rows)
    @invoice_item_repository  = InvoiceItemRepository.new(self, @invoice_item_rows)
    @item_repository          = ItemRepository.new(self, @item_rows)
    @transaction_repository   = TransactionRepository.new(self, @transaction_rows)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_all_by('invoice_id',id)
  end

end
