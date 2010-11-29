require 'rubygems'
require 'sinatra'
require 'brb'

get '/' do
  server = BrB::Tunnel.create(nil, "brb://localhost:5556")
  res = server.diagnose_block
  EM.stop
  res
end
