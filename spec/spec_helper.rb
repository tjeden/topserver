$LOAD_PATH << File.join(File.dirname(__FILE__),"..")

TEST_ENV = true unless defined?(TEST_ENV)

require 'rspec'
require 'sqlite3'
require 'database_cleaner'
require 'factory_girl'
require 'topserver'
require 'spec/factories'

def clean_file(filename)
  File.delete(filename) if File.exists?(filename)
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
