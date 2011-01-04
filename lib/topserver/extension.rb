class Extension
  attr_reader :input_file, :output_file, :delimeter
  @@children =[]

  def initialize(input_file, output_file, delimeter)
    @input_file = input_file
    @output_file = output_file
    @delimeter = delimeter
  end

  def close_output
    @output.close
  end
  
  def write(data)
    raise 'Should be implemented in subclass'
  end

  def read
    raise 'Should be implemented in subclass'
  end

  def source
    raise 'Should be implemented in subclass'
  end

  def output
    raise 'Should be implemented in subclass'
  end

  def self.children
    @@children
  end

end
