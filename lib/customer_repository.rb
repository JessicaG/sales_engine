require_relative 'customer'
require_relative 'repository_parser'

class CustomerRepository
  attr_reader :customers, :sales_engine

  def initialize(engine, customer_attributes=[])
    @sales_engine = engine
    @customers    = customer_attributes.collect { |attributes| Customer.new(attributes, self) }
  end

  def inspect
     "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    @customers
  end

  def random
    customers.sample
  end

  def count
    customers.count
  end

  def find_by(attribute, value)
    customers.detect do |customer|
      customer.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_all_by(attribute, value)
    customers.select do |customer|
      customer.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_by_first_name(value)
    find_by('first_name', value)
  end

  def find_by_last_name(value)
    find_by('last_name', value)
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_all_by_first_name(value)
    find_all_by('first_name', value)
  end

  def find_all_by_last_name(value)
    find_all_by('last_name', value)
  end

  def find_invoices_by_customer_id(id)
    sales_engine.find_invoices_by_customer_id(id)
  end


end
