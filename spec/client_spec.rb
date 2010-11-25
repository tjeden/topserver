require 'spec_helper' 

describe Client do
  describe '#on create' do
    before :each do
      @task = double('task')
      @client = Client.new( :ip => '192.168.0.13', :task => @task )
    end

    it 'assignes task' do
      @client.task.should eql(@task)
    end

    it 'assignes ip' do
      @client.ip.should eql('192.168.0.13')
    end

    it 'sets default port' do
      @client.port.should eql('80')
    end

    it 'assgines given port' do
      @client = Client.new( :ip => '192.168.0.13', :task => @task, :port => '8080')
      @client.port.should eql('8080')
    end

    it 'is available' do
      @client.available?
    end
  end

  describe '#send_task' do
    before :each do
      @task = double('task')
      @task.stub!(:get_data).and_return('test',1)
      @client = Client.new( :ip => '192.168.0.13', :task => @task )
    end

    it 'sends post to client address' do
      EM.should_receive(:connect)
      @client.send_task
    end

    it 'sets available to false' do
      EM.stub!(:connect)
      @client.send_task
      @client.available?.should be_false
    end
  end
end
