Given /^a server exists$/ do
  @server = Server.new
  @server.start
end

Given /^a client exists$/ do
   FakeWeb.register_uri(:post, 'http://www.example.com/', :body => 'response_for_linguara', :status => 200)
end

Given /^a task exists$/ do
  @task = Task.new( :name => 'foo')
end

Given /^a client is registered in server with that task$/ do
  @server.register_client( :task_name => @task.name, :ip => '192.168.0.13')
end

When /^server notice there is a task, which can be done by client$/ do
  @server.tasks << @task 
end

Then /^server should send task to client$/ do
  sleep 20
  request = FakeWeb.last_request
  request.path.should eql('http://www.example.com/')
  request.should be(Net::HTTP::Post)
end

