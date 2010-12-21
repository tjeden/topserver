require 'eventmachine'
require 'socket'
require 'workflow'
require 'trollop'
require 'brb'
require 'yaml'
require 'active_record'

dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)

require 'lib/topserver/server'
require 'lib/topserver/task'
require 'lib/topserver/client'
require 'lib/topserver/listener'
require 'lib/topserver/sender'
require 'lib/topserver/logger'
require 'lib/topserver/extension'
require 'lib/topserver/extensions_loader'
require 'lib/topserver/task_loader'

