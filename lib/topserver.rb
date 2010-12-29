# Third party gems 
require 'eventmachine'
require 'socket'
require 'workflow'
require 'trollop'
require 'brb'
require 'yaml'
require 'mongo_mapper'
require 'active_record'

# ActiveRecord database initialization
if defined?(TEST_ENV)
  dbconfig = YAML::load(File.open('config/test_database.yml'))
  ActiveRecord::Base.establish_connection(dbconfig)
  ActiveRecord::Migrator.up('db/migrate') 
else
  dbconfig = YAML::load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection(dbconfig)
end

# MongoMapper database initialization
MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "#topserver"

# Serwer files
require 'lib/topserver/server'
require 'lib/topserver/task'
require 'lib/topserver/client'
require 'lib/topserver/listener'
require 'lib/topserver/sender'
require 'lib/topserver/logger'
require 'lib/topserver/extension'
require 'lib/topserver/extensions_loader'
require 'lib/topserver/task_loader'
require 'lib/topserver/result'
require 'lib/topserver/datapack'

