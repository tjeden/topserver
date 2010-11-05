$LOAD_PATH << File.join(File.dirname(__FILE__),"..")

require 'rspec'
require 'file_extension'
require 'server'
require 'task'
require 'client'

def clean_file(filename)
  File.delete(filename) if File.exists?(filename)
end
