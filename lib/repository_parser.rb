require 'csv'

class RepositoryParser

  def self.load(filename, class_name: nil)
    objects   = CSV.open(filename,
      headers: true, header_converters: :symbol).collect do |row|
        class_name.new(row)
      end
  end

end
