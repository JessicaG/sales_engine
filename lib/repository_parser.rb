require 'csv'

class RepositoryParser
  def self.load(filename, class_name: nil)
    objects   = CSV.open(filename, headers: true, header_converters: :symbol)
  end
end
