class Task
  include Workflow

  workflow do
    state :working do
      event :close, :transitions_to => :closed
    end
    state :closed
  end

  attr_accessor :name, :counter, :timeout

  def initialize(opts={})
    @name = opts[:name]
    @file_extension = BinaryFileExtension.new('foo', 'data/owles.jpg', 'data/output.jpg', ';')
    @end_of_data = false
    @counter = 0
    @recieved = 0
    @result = []
    @timeouted = []
    @timeout = 10
  end

  def get_data
    if @timeouted.size > 0
      @timeouted.pop
    else
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
  end

  def write_data(data, counter)
    @result[counter] = data
    @recieved += 1
  end

  def close_task
    @result.each do |data|
      @file_extension.write(data)
    end
    @file_extension.close_output
    close!
  end

  def completed?
    !closed? && @end_of_data && @counter != 0 && @recieved == @counter
  end

  def add_timeouted_data(data, number) 
    @timeouted << [data,number] 
  end
end
