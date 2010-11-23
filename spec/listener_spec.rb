require 'spec_helper'

describe Listener do
  before :each do
    @server = Server.new
    @server.tasks << Task.new(:name => 'foo')
    @listener = Listener.new('')
    @listener.server = @server
  end

  describe '#receive_data' do
    context 'on register' do
      before :each do
        @data = 'REGISTER 123.123.123.123 5555 foo'
      end

      it 'registers new client' do
        lambda {
          @listener.stub!(:send_data)
          @listener.receive_data(@data)
        }.should change(@server.clients, :size).by(1)
      end

      it 'responds with new client id' do
        @listener.should_receive(:send_data).with(0)
        @listener.receive_data(@data)
      end
    end

    context 'on data' do
      before :each do
        @data = 'RESPONSE 0 dummy_data'
        @server.register_client( :task_name => 'foo')
      end

      xit 'saves data' do
      end

      it 'responds with succcess status' do
        @server.clients.first.stub!(:receive_task)
        @listener.should_receive(:send_data).with('OK')
        @listener.receive_data(@data)
      end
    end
  end
end
