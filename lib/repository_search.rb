require_relative 'repository_parser'

class RepositorySearch

  attr_reader :repository_objects

  def initialize(filename)
    @repository_objects = load(filename)
  end

  def all
    @repository_objects
  end

  def random
    @repository_objects.shuffle.sample
  end

  def find_by(attribute, *args)

  end

end
