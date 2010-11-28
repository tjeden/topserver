$LOAD_PATH << File.join(File.dirname(__FILE__),"..")

require 'lib/topserver'

opts = Trollop::options do
  opt :port, "Specify port", :default => 5555
  opt :ip, "Specify IP", :default => '0.0.0.0' 
end

EventMachine.run {
  server = Server.new
  server.log "Top server started on ip: #{opts[:ip]} port: #{opts[:port]}"
  server.tasks << Task.new(:name => 'foo')
  EM::PeriodicTimer.new(0.25) do
    server.send_tasks_to_clients
    server.close_tasks
    server.check_timeouts
  end
  EM::PeriodicTimer.new(1.0) do
    server.diagnose
  end
  EM.start_server opts[:ip], opts[:port], Listener do |conn|
    conn.server = server
  end
}

