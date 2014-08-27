require_relative 'invoice'
require 'pry'

class InvoiceRepository
  attr_reader :invoices, :sales_engine

  def initialize(engine, invoice_attributes=[])
    @sales_engine  = engine
    @invoices      = invoice_attributes.collect { |attributes| Invoice.new(attributes, self) }
  end

  def inspect
     "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def random
    invoices.sample
  end

  def count
    invoices.count
  end

  def find_by(attribute, value)
    invoices.detect do |invoice|
      invoice.send(attribute) == value
    end
  end

  def find_all_by(attribute, value)
    invoices.select do |invoice|
      invoice.send(attribute) == value
    end
  end

  def find_by_status(value)
    find_by('status', value)
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_all_by_invoice_id(value)
    find_all_by('invoice_id', value)
  end

  def find_all_by_status(value)
    find_all_by('status', value)
  end

  def find_all_by_customer_id(value)
    find_all_by('customer_id', value)
  end

  def find_all_by_merchant_id(value)
    find_all_by('merchant_id', value)
  end

  def find_transactions_by_invoice_id(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_items_by_invoice_id(id)
    sales_engine.find_items_by_invoice_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    sales_engine.find_customer_by_customer_id(customer_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def create(options = {})
    invoice_id = count + 1
    new_invoice_items(options, invoice_id)
    invoice = new_invoice(options)
    invoices << invoice
    invoice

  end

  def new_invoice(options)
    data = {id:                     count + 1,
            customer_id:            options[:customer].id,
            merchant_id:            options[:merchant].id,
            created_at:             Time.new.utc.to_s,
            updated_at:             Time.new.utc.to_s,
            status:                 options[:status]
            }

  Invoice.new(data,self)
  end

  def new_invoice_items(options, invoice_id)
    sales_engine.new_invoice_items(options, invoice_id)
  end

  def new_transacation(options, id)
    sales_engine.new_transacation(options, id)
  end

end
