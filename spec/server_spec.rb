require 'spec_helper'

describe Server do
  describe '#on create' do
    before :each do
      @server = Server.new
    end

    it 'clients are empty' do
      @server.clients.should be_empty
    end

    it 'tasks are empty' do
      @server.tasks.should be_empty
    end

  end

  describe '#register_client' do
    before :each do
      @server = Server.new
    end

    it 'adds new client' do
      lambda {
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
      }.should change(@server.clients, :count).by(1)
    end

    it 'assigns correct task to client' do
      task = Task.new( :name => 'foo')
      @server.tasks << task
      @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
      @server.clients.last.task.should eql(task)
    end

    it 'assigns ip to client' do
      @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
      @server.clients.last.ip.should eql('192.168.0.13')
    end
  end

end
