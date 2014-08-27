require_relative 'repository_parser'
require_relative 'sales_engine'

module RepositorySearch

  attr_reader :objects

  def initialize(filename)
    @objects = load(filename)
  end

  def inspect
    "<#Repositories>"
  end

  def all
    @objects
  end

  def random
    @objects.shuffle.sample
  end

  def find_by(method, *args)
    method_name = method.to_s.split("find_by_").last
    @objects.find { |object| object.send(method_name) == args.first }
  end

  def find_all_by(method, *args)
    method_name = method.to_s.split("find_all_by_").last
    @objects.select { |object| object.send(method_name) == args.first }
  end

end
