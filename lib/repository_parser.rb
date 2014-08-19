# require_relative 'transaction'
# require_relative 'item'
# require_relative 'invoice_item'
# require_relative 'customer'
# require_relative 'invoice'
require 'csv'

class RepositoryParser

  def self.load(filename, class_name: nil)
    objects   = CSV.open(filename,
      headers: true, header_converters: :symbol).collect do |row|
        class_name.new(row)
      end
  end

end
