class Task
  include Workflow

  workflow do
    state :working do
      event :close, :transitions_to => :closed
    end
    state :closed
  end

  attr_accessor :name, :counter

  def initialize(opts={})
    @name = opts[:name]
    @file_extension = BinaryFileExtension.new('foo', 'data/owles.jpg', 'data/output.jpg', ';')
    @end_of_data = false
    @counter = 0
    @result = []
  end

  def get_data
    data = nil
    unless @end_of_data
      data = @file_extension.read 
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

  def close_task
    @result.each do |data|
      @file_extension.write(data)
    end
    @file_extension.close_output
  end

  def completed?
    !closed? && @end_of_data 
  end
end
