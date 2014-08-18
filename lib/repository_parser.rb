module RepositoryParser

  def load(filename)
    class_name = Kernel.const_get(self.class.to_s.gsub("Repository", ""))
    objects   = CSV.open(filename,
      headers: true, header_converters: :symbol).collect do |row|
        class_name.new(row)
      end
  end
  
end
