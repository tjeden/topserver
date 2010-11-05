Given /^a server exists$/ do
  @server = Server.new
  @server.start
end

Given /^a client exists$/ do
  FakeWeb.register_uri(:post, '192.168.0.13', :response => "response_from_example.com")
end

Given /^a task exists$/ do
  @task = Task.new( :name => 'foo')
end

Given /^a client is registered in server with that task$/ do
  @server.register_client( :task_name => @task.name, :ip => '192.168.0.13')
end

When /^server notice there is a task, which can be done by client$/ do
  @server.tasks << Task.new
end

Then /^server should send task to client$/ do
  FakeWeb.last_request.should eql('192.168.0.13')
end

