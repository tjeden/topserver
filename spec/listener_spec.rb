require 'spec_helper'

describe Listener do
  before :each do
    @server = Server.new
    @listener = Listener.new('')
    @listener.server = @server
  end

  describe '#receive_data' do
    context 'on register' do
      before :each do
        @task = Factory :task
        @data = 'REGISTER 123.123.123.123 5555 foo'
      end

      it 'registers new client' do
        lambda {
          @listener.stub!(:send_data)
          @listener.receive_data(@data)
        }.should change(Client, :count).by(1)
      end

      it 'responds with new client id' do
        @listener.should_receive(:send_data).with(1)
        @listener.receive_data(@data)
      end
    end

    context 'on data' do
      before :each do
        @client = Factory :client
        @data = "RESPONSE #{@client.id} dummy_data"
        @server.stub!(:find_client).and_return(@client)
      end

      it 'saves data' do
        @client.should_receive(:receive_task).with('dummy_data')
        @listener.stub!(:send_data)
        @listener.receive_data(@data)
      end

      it 'responds with succcess status' do
        @client.stub!(:receive_task)
        @listener.should_receive(:send_data).with('OK')
        @listener.receive_data(@data)
      end
    end

    context 'on data for inactive client' do
      before :each do
        client = Factory :client, :inactive => true
        @data = "RESPONSE #{client.id} dummy_data"
        @server.register_client( :task_name => 'foo')
      end

      it 'brings client back to life' do
        @listener.stub!(:send_data)
        @listener.receive_data(@data)
        @server.clients.first.should_not be_inactive
      end

      it 'does not saves data' do
        @server.clients.first.should_not_receive(:receive_task)
        @listener.stub!(:send_data)
        @listener.receive_data(@data)
      end

      it "saves client's history" do
        @listener.stub!(:send_data)
        lambda {
          @listener.receive_data(@data)
        }.should change(Statistic, :count).by(1)
        statistic = Statistic.last
        statistic.clients_total.should eql(2)
        statistic.available_clients.should eql(2)
        statistic.inactive_clients.should eql(0)
        statistic.active_clients.should eql(2)
      end

      it 'responds with succcess status' do
        @server.clients.first.stub!(:receive_task)
        @listener.should_receive(:send_data).with('OK')
        @listener.receive_data(@data)
      end
    end
  end
end
