class FileExtension < Extension

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

  private

  def source
    @source_file ||= File.new(@input_file, 'r')
  end

  def output
    @output ||= File.new(@output_file, 'w')
  end
end
