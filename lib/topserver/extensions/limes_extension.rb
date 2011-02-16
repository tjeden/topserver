class LimesExtension < Extension
  
  def read(counter)
    if counter < 30_000
      a = ""
      10_000.times{ a += "#{rand} "}
      a
    else
      nil
    end
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
  
  def counter_size(data)
    10_000
  end
end
