$LOAD_PATH << File.join(File.dirname(__FILE__),"..")

require 'lib/topserver'

EventMachine.run {
  puts 'Top server started'
  server = Server.new
  server.tasks << Task.new(:name => 'foo')
  server.register_client( :ip => '0.0.0.0', :task_name => 'foo', :port => '8080')
  EM::PeriodicTimer.new(0.25) do
    server.send_tasks_to_clients
  end

}

