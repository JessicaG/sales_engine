require 'csv'

class RepositoryParser
  def self.load(filename)
    objects   = CSV.open(filename, headers: true, header_converters: :symbol)
  end
end
