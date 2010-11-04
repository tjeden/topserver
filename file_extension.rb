class FileExtension

  attr_reader :task_type, :input_file, :output_file, :delimeter

  def initialize(task_type, input_file, output_file, delimeter)
    @task_type = task_type
    @input_file = input_file
    @output_file = output_file
    @delimeter = delimeter
  end

  def get_data
    #TODO I don't like this -2
    source.gets(@delimeter)[0..-2]
  end

  private

  def source
    @source_file ||= File.new(@input_file, 'r')
  end
end
