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

    it 'is available' do
      @client.available?
    end
  end

  describe '#send_task' do
    before :each do
      @task = double('task')
      @client = Client.new( :ip => '192.168.0.13', :task => @task )
    end

    xit 'sends post to client address' do
    end

    it 'sets available to false' do
      @client.send_task
      @client.available?.should be_false
    end
  end
end
