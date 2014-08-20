require_relative 'invoice'
require_relative 'repository_parser'

class InvoiceRepository
  attr_reader :invoices

  def initialize(file = './data/invoices.csv')
    @invoices = RepositoryParser.load(file, class_name: Invoice)
  end

  def inspect
     "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    @invoices
  end

  def random
    invoices.shuffle.pop
  end

  def count
    invoices.count
  end

  def no_attribute_error(attribute)
    invoice.send(attribute) == value
    puts "That #{attribute} doesn't exist"
  end

  def find_by(attribute, value)
    invoices.detect do |invoice|
      if !invoice.respond_to?(attribute)
        no_attribute_error(attribute)
      else
      invoice.send(attribute).downcase == value.downcase
      end
    end
  end

  def find_all_by(attribute, value)
    invoices.select do |invoice|
      if !invoice.respond_to?(attribute)
        no_attribute_error(attribute)
      else
      invoice.send(attribute).downcase == value.downcase
      end
    end
  end

  def find_by_status(value)
    find_by('status', value)
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_all_by_id(value)
    find_all_by('id', value)
  end

  def find_all_by_status(value)
    find_all_by('status', value)
  end

end
