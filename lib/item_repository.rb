require_relative 'repository_parser'

class ItemRepository

  attr_reader :items

  def initialize(file = './data/items.csv')
    @items = RepositoryParser.load(file, class_name: Item)
  end

  def all
    @items
  end

  def random
    @items.sample
  end

  def find_by_id_number(attribute)
    @items.detect {|item| item.id =~ /^#{attribute}$/i}
  end
  ##Methods needed for all, random, inspect,
  ##find by, fina all by,
  ##find all by name
end
