$LOAD_PATH << File.join(File.dirname(__FILE__),"..")

require 'rspec'
require 'topserver'

TEST_ENV = true unless defined?(TEST_ENV)

def clean_file(filename)
  File.delete(filename) if File.exists?(filename)
end
