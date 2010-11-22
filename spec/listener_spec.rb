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
        @data = 'REGISTER 123.123.123.123 5555 foo'
      end

      it 'registers new client' do
        @listener.receive_data(@data)
      end

      it 'responds with new client id' do
      end
    end

    context 'on data' do
      it 'saves data' do
      end

      it 'responds with succcess status' do
      end
    end
  end
end
