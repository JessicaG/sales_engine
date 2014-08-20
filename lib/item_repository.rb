require_relative 'repository_parser'

class ItemRepository

  attr_reader :items

  def initialize(file = './data/items.csv')
    @items = RepositoryParser.load(file, class_name: Item)
  end

  ##Methods needed for all, random, inspect,
  ##find by, fina all by,
  ##find all by name
end
