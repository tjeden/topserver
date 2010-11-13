class Task
  attr_accessor :name, :counter

  def initialize(opts={})
    @name = opts[:name]
    @fe = BinaryFileExtension.new('foo', 'data/owles.jpg', 'data/output.jpg', ';')
    @end_of_data = false
    @counter = 0
    @result = []
  end

  def get_data
    data = nil
    unless @end_of_data
      data = @fe.read 
      @end_of_data = true if data.nil?
    end
    if data
      @result << nil
      @counter += 1
      [data, @counter -1]
    else
      nil
    end
  end

  def write_data(data, counter)
    @result[counter] = data
  end

  def end_writing
    @result.each do |data|
      @fe.write(data)
    end
    @fe.close_output
  end
end
