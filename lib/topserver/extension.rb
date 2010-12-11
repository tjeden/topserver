class Extension
  attr_reader :task_type, :input_file, :output_file, :delimeter

  def initialize(task_type, input_file, output_file, delimeter)
    @task_type = task_type
    @input_file = input_file
    @output_file = output_file
    @delimeter = delimeter
  end

  def close_output
    @output.close
  end
  
  def write
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
end
