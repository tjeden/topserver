class Task
  attr_accessor :name

  def initialize(opts={})
    @name = opts[:name]
  end
end
