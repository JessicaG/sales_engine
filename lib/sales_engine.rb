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
              :directory,
              :merchant_rows,
              :customer_rows,
              :invoice_rows,
              :invoice_item_rows,
              :item_rows,
              :transaction_rows

  def initialize(directory = './test/fixtures')
    @directory = directory
  end

  def load_repositories
   @merchant_rows     = RepositoryParser.load(@directory + '/merchants.csv')
   @customer_rows     = RepositoryParser.load(@directory + '/customers.csv')
   @invoice_rows      = RepositoryParser.load(@directory + '/invoices.csv')
   @invoice_item_rows = RepositoryParser.load(@directory + '/invoice_items.csv')
   @item_rows         = RepositoryParser.load(@directory + '/items.csv')
   @transaction_rows  = RepositoryParser.load(@directory + '/transactions.csv')
  end

  def startup
    load_repositories
    @merchant_repository      = MerchantRepository.new(self, merchant_rows)
    @customer_repository      = CustomerRepository.new(self, customer_rows)
    @invoice_repository       = InvoiceRepository.new(self, invoice_rows)
    @invoice_item_repository  = InvoiceItemRepository.new(self, invoice_item_rows)
    @item_repository          = ItemRepository.new(self, item_rows)
    @transaction_repository   = TransactionRepository.new(self, transaction_rows)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by('merchant_id',id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by('merchant_id',id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_all_by('invoice_id',id)
  end

  #Transaction: invoice returns an instance of Invoice associated with this object
  def find_invoice_by_transaction_id(id)
    invoice_repository.find_by(id,'invoice_id')
  end

  #Customer: invoices returns a collection of Invoice instances associated with this object.
  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by(id,'customer_id')
  end

  #Invoice: invoice_items returns a collection of InvoiceItems associated with this object
  def find_invoice_items_by_item_id(id)
    invoice_repository.find_all_by(id, 'item_id')
  end

  #Invoice: merchant returns an instance of Merchant associated with this object
  def find_merchants_by_item_id(id)
    merchant_repository.find_by(id, 'item_id')
  end

  #InvoiceItems: invoice returns an instance of Invoice associated with this object
  def find_invoice_by_invoice_item_id(id)
    invoice_repository.find_by(id, 'invoice_id')
  end

  #InvoiceItems: item returns an instance of Item associated with this object
  def find_item_by_item_id(id)
    item_repository.find_by(id,'item_id')
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_by('invoice_id',id)
  end

  def find_items_by_invoice_id(id)
    items(id).select { |item| item != nil}
  end

  def items(id)
    invoice_items(id).map{|invoice_item| item_repository.find_by('id', invoice_item.item_id )}
  end

  def invoice_items(id)
    invoice_item_repository.find_all_by('invoice_id', id)
  end

  def find_customer_by_customer_id(customer_id)
    customer_repository.find_by('id', customer_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchant_repository.find_by('id',merchant_id)
  end

end
