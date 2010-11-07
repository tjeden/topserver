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

  def source
    @source_file ||= File.new(@input_file, 'rb')
  end
end
