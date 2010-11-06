class FileExtension

  attr_reader :task_type, :input_file, :output_file, :delimeter

  def initialize(task_type, input_file, output_file, delimeter)
    @task_type = task_type
    @input_file = input_file
    @output_file = output_file
    @delimeter = delimeter
  end

  def read
    #TODO I don't like this -2
    data = source.gets(@delimeter)
    if data
      data[0..-2]
    else
      source.close
    end
  end

  def write(data)
    output.puts(data)
  end

  def close_output
    @output.close
  end
  
  private

  def source
    @source_file ||= File.new(@input_file, 'r')
  end

  def output
    @output ||= File.new(@output_file, 'w')
  end
end
