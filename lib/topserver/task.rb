class Task
  attr_accessor :name

  def initialize(opts={})
    @name = opts[:name]
    @fe = BinaryFileExtension.new('foo', 'data/owles.jpg', 'output.txt', ';')
    @end_of_data = false
  end

  def get_data
    data = nil
    unless @end_of_data
      data = @fe.read 
      @end_of_data = true if data.nil?
    end
    data
  end
end
