Dir.new("lib/topserver/extensions").each do |file_name|
  if file_name.match(/\.rb$/)
    begin 
      require "lib/topserver/extensions/#{file_name}"
      Extension.children << file_name.split('.')[0].camelize
    rescue LoadError
      raise "Cannot load extension: lib/topserver/extensions/#{file_name}"
    end
  end
end
