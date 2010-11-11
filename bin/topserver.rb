$LOAD_PATH << File.join(File.dirname(__FILE__),"..")

require 'lib/topserver'

EventMachine.run {
  puts 'Top server started'
  server = Server.new
  server.tasks << Task.new(:name => 'foo')
  EM::PeriodicTimer.new(0.25) do
    server.send_tasks_to_clients
  end
  EM.start_server '0.0.0.0', 5555, Listener do |conn|
    conn.server = server
  end

}

