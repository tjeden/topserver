require 'spec_helper'

describe Server do
  before :each do
    @server = Server.new
  end

  describe '#on create' do
    it 'clients are empty' do
      @server.clients.should be_empty
    end

    it 'tasks are empty' do
      @server.tasks.should be_empty
    end

  end

  describe '#register_client' do
    before :each do
      @task = Task.new( :name => 'foo')
      @server.tasks << @task
      @server.register_client( :task_name => 'foo', :ip => '192.168.0.13', :port => '8080')
    end

    it 'adds new client' do
      lambda {
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
      }.should change(@server.clients, :count).by(1)
    end

    it 'assigns correct task to client' do
      @server.clients.last.task.should eql(@task)
    end

    it 'assigns ip to client' do
      @server.clients.last.ip.should eql('192.168.0.13')
    end

    it 'assigns port to client' do
      @server.clients.last.port.should eql('8080')
    end
  end

  describe '#send_task_to_client' do
    context 'when there is no clients' do
      it 'does nothing' do
        @server.send_tasks_to_clients
      end
    end

    context 'when there is availible client and task' do
      before :each do
        @task = Task.new( :name => 'foo')
        @server.tasks << @task
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
      end

      it 'sends task' do
        @server.clients.first.should_receive(:send_task)
        @server.send_tasks_to_clients
      end
    end

    context 'when client is unavailible ' do
      before :each do
        @task = Task.new( :name => 'foo')
        @server.tasks << @task
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
        @server.clients.first.stub!(:available?).and_return(false)
      end

      it 'does not send task' do
        @server.clients.first.should_not_receive(:send_task)
        @server.send_tasks_to_clients
      end
    end

    context 'when client is availible but task is completed' do
      before :each do
        @task = Task.new( :name => 'foo')
        @task.stub!(:completed?).and_return(true)
        @server.tasks << @task
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
        @server.clients.first.stub!(:available?).and_return(true)
      end

      it 'does not send task' do
        @server.clients.first.should_not_receive(:send_task)
        @server.send_tasks_to_clients
      end
    end
  end

  describe '#check_timeouts' do
    
  end

  describe '#close_tasks' do
    context 'when there are not any tasks' do
      it 'does nothin' do
        @server.close_tasks
      end
    end

    context 'when there is completed task' do
      it 'closes task' do
        @task = Task.new( :name => 'foo')
        @task.stub!(:completed?).and_return(true)
        @server.tasks << @task
        @task.should_receive(:close_task)
        @server.close_tasks
      end
    end

    context 'when there are not any completed task' do
      it 'closes task' do
        @task = Task.new( :name => 'foo')
        @task.stub!(:completed?).and_return(false)
        @server.tasks << @task
        @task.should_not_receive(:close_task)
        @server.close_tasks
      end
    end
  end

end
