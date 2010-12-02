require 'rubygems'
require 'sinatra'
require 'brb'
require 'haml'
require 'sinatra/static_assets'
require 'json'

set :views, File.dirname(__FILE__) + '/../templates'
set :public, File.dirname(__FILE__) + '/../public'

get '/' do
  server = BrB::Tunnel.create(nil, "brb://localhost:5556")
  res = server.diagnose_block
  EM.stop
  haml :index
end

get '/active_clients' do
  content_type :json
  [[Time.now.to_i, '2'], [(Time.now + 500).to_i, '3'] , [(Time.now + 1300).to_i,'5']].to_json
end
