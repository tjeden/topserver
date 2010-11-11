class BinaryFileExtension < FileExtension
  
  def read
    data = source.gets
    if data
      data
    else
      source.close
    end
  rescue NoMethodError
    source.close
  end

  def write(data)
    output.puts(data)
  end

  def source
    @source_file ||= File.new(@input_file, 'rb')
  end

  def output
    @output ||= File.new(@output_file, 'wb')
  end
end
