class Task
  attr_accessor :name

  def initialize(opts={})
    @name = opts[:name]
    @fe = FileExtension.new('foo', 'data/dummy_file.txt', 'output.txt', ';')
  end

  def get_data
    @fe.read
  end
end
