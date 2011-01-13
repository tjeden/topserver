require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'brb'
require 'haml'
require 'sinatra/static_assets'
require 'json'

$LOAD_PATH << File.join(File.dirname(__FILE__),"..")
require 'lib/topserver'

set :views, File.dirname(__FILE__) + '/../views'
set :public, File.dirname(__FILE__) + '/../public'

require 'lib/webapp/tasks'

get '/stats' do
  haml :stats 
end

get '/clients_history' do
  content_type :json
  Statistic.all.map{ |s| [s.updated_at.to_i, s.clients_total, s.available_clients, s.inactive_clients, s.active_clients]}.to_json
end

get '/current_clients' do
  content_type :json
  s = Statistic.last
  [s.clients_total, s.available_clients, s.inactive_clients, s.active_clients].to_json
end
