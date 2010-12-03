require 'rubygems'
require 'sinatra'
require 'brb'
require 'haml'
require 'sinatra/static_assets'
require 'json'

set :views, File.dirname(__FILE__) + '/../templates'
set :public, File.dirname(__FILE__) + '/../public'

get '/' do
  haml :index
end

get '/clients_history' do
  content_type :json
  server = BrB::Tunnel.create(nil, "brb://localhost:5556")
  res = server.clients_history_block
  EM.stop
  res.map{|e| [e[0].to_i,e[1]]}.to_json
end

get '/active_clients' do
  content_type :json
  server = BrB::Tunnel.create(nil, "brb://localhost:5556")
  res = server.active_clients_block
  EM.stop
  res.to_json
end
