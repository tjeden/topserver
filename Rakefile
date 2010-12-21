$LOAD_PATH << File.join(File.dirname(__FILE__) )
require 'lib/topserver.rb'

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

desc "Loads task from config/tasks.yml file"
task :tasks_load do
  TaskLoader.load
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml')))
end


