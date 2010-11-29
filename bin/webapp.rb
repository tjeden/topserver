require 'rubygems'
require 'sinatra'
require 'brb'
require 'haml'

set :views, File.dirname(__FILE__) + '/../templates'

get '/' do
  server = BrB::Tunnel.create(nil, "brb://localhost:5556")
  res = server.diagnose_block
  EM.stop
  haml :index
end
