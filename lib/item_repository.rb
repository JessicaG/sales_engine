require_relative 'repository_parser'

class ItemRepository

  attr_reader :items

  def initialize(file = './test/fixtures/items.csv', engine)
    @items = create_items_from(file)
    @sales_engine = engine
  end

  def create_items_from(file)
    csv = RepositoryParser.load(file, class_name: Item)
    csv.collect { |row| Item.new(row, self) }
  end

  def inspect
     "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def random
    items.sample
  end

  def find_by(attribute, value)
    items.detect do |item|
      item.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_all_by(attribute, value)
    items.select do |item|
      item.send(attribute) =~ /^#{value}$/i
    end
  end

  def find_by_id(value)
    find_by('id', value)
  end

  def find_all_by_merchant_id(value)
    find_all_by('merchant_id',value)
  end

end
