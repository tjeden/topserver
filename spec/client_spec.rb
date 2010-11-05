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
  end
end
