class BinaryFileExtension < FileExtension
  
  def read
    data = source.gets.unpack('L*')
#    puts data
    if data
      data
    else
      source.close
    end
  end
end
