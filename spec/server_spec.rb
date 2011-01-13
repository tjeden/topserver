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

    it 'has empty clients history' do
      @server.clients_history.should be_empty
    end
  end

  describe '#register_client' do
    before :each do
      @task = Factory :task
      @server.register_client( :task_name => 'foo', :ip => '192.168.0.13', :port => '8080')
    end

    it 'adds new client' do
      lambda {
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
      }.should change(Client, :count).by(1)
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

    it 'saves time in history' do
      @server.clients_history.size.should eql(1)
      @server.clients_history[0][0].is_a?(Time).should be_true
      @server.clients_history[0][1].should eql(1)
    end

    describe 'with non existing task' do
      it 'cannot be sucessfull' do
        lambda {
          @server.register_client( :task_name => 'invalid', :ip => '192.168.0.13')
        }.should_not change(@server, :active_clients)
      end

      it 'returns -1' do
        @server.register_client( :task_name => 'invalid', :ip => '192.168.0.13').should eql(-1)
      end
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
        @task = Factory :task
        @client = Factory :client
        @server.stub!(:clients).and_return([@client])
      end

      it 'sends task' do
        @client.should_receive(:send_task)
        @server.send_tasks_to_clients
      end
    end

    context 'when client is unavailible ' do
      before :each do
        @task = Factory :task
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
        @server.clients.first.update_attribute(:available, false)
      end

      it 'does not send task' do
        @server.clients.first.should_not_receive(:send_task)
        @server.send_tasks_to_clients
      end
    end

    context 'when client is availible but task is completed' do
      before :each do
        @task = Factory :task
        @task.stub!(:completed?).and_return(true)
        @client = Factory :client, :task => @task
        @client.stub!(:available?).and_return(true)
        @server.stub(:clients).and_return([@client])
      end

      it 'does not send task' do
        @client.should_not_receive(:send_task)
        @server.send_tasks_to_clients
      end
    end
  end

  describe '#check_timeouts' do
    context 'when there is client with terminated task' do
      before :each do
        @task = Task.create( :name => 'foo', :extension_name => 'binary_file_extension')
        @server.register_client( :task_name => 'foo', :ip => '192.168.0.13')
        @terminated_client = @server.clients.first
        @terminated_client.stub!(:terminated?).and_return(true)
        @server.stub(:clients).and_return([@terminated_client])
      end

      it 'terminate that task' do 
        @terminated_client.should_receive(:terminate)   
        @server.check_timeouts 
      end

      it 'saves that in history' do
        @terminated_client.stub!(:terminate)
        lambda{
          @server.check_timeouts 
        }.should change(@server.clients_history, :size).by(1)
      end
    end
  end

  describe '#close_tasks' do
    context 'when there are not any tasks' do
      it 'does nothing' do
        @server.close_tasks
      end
    end

    context 'when there is completed task' do
      it 'closes task' do
        @task = Task.new( :name => 'foo')
        @task.stub!(:completed?).and_return(true)
        @task.should_receive(:close_task)
        @server.stub(:tasks).and_return([@task])
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
