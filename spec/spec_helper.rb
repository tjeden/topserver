$LOAD_PATH << File.join(File.dirname(__FILE__),"..")

require 'rspec'
require 'topserver'

def clean_file(filename)
  File.delete(filename) if File.exists?(filename)
end
