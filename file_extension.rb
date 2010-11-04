class FileExtension

  attr_reader :task_type, :input_file, :output_file, :delimeter

  def initialize(task_type, input_file, output_file, delimeter)
    @task_type = task_type
    @input_file = input_file
    @output_file = output_file
    @delimeter = delimeter
  end
end
