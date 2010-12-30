require 'spec_helper' 

describe Client do
  describe '#on create' do
    before :each do
      @task = Factory :task
      @client = Client.create( :ip => '192.168.0.13', :task => @task )
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

    it 'assignes given port' do
      @client = Client.new( :ip => '192.168.0.13', :task => @task, :port => '8080')
      @client.port.should eql('8080')
    end

    it 'is available' do
      @client.available?
    end

    it 'has blank data_pack' do
      @client.data_pack.should be_nil
    end

    it 'has blank send_at' do
      @client.instance_variable_get(:@send_at).should be_nil
    end
  end

  describe '#send_task' do
    before :each do
      @task = Factory :task
      @data_pack = Factory :data_pack, :task => @task
      @task.stub!(:get_data).and_return(@data_pack)
      @client = Client.create( :ip => '192.168.0.13', :task => @task )
    end

    it 'sends post to client address' do
      EM.should_receive(:connect)
      @client.send_task
    end

    it 'sets send_at' do
      EM.stub!(:connect)
      @client.send_task
      @client.send_at.should_not be_nil
    end

    it 'sets available to false' do
      EM.stub!(:connect)
      @client.send_task
      @client.should_not be_available
    end

    it 'sets data_pack to sent' do
      EM.stub!(:connect)
      @client.send_task
      @data_pack.should be_sent
    end
  end

  describe '#terminated?' do
    before :each do
      @task = Factory :task
      @task.stub!(:timeout).and_return(60)
      @client = Client.new( :task => @task)
    end

    context 'when client is available' do
      before :each do @client.stub!(:available?).and_return(true) end

      it 'is false' do
        @client.should_not be_terminated
      end
    end

    context 'when client is not available' do
      before :each do 
        @client.available = false 
      end

      context 'and task was sent over 60 seconds ago' do
        it 'is true' do
          @client.send_at = Time.now - 70
          @client.should be_terminated
        end
        
        context 'and clients is inactive' do
          it 'is false' do
            @client.instance_variable_set(:@inactive, true)
            @client.instance_variable_set(:@send_at, Time.now - 70)
            @client.should_not be_terminated
          end
        end
      end

      context 'and task was sent less than 60 seconds ago' do
        it 'is false' do
          @client.instance_variable_set(:@send_at, Time.now - 10)
          @client.should_not be_terminated
        end
      end

      context 'when send_at is nil' do
        it 'is false' do
          @client.should_not be_terminated
        end
      end
    end
  end

  describe '#terminate' do
    before :each do
      @task = Factory :task
      @task.stub!(:add_timeouted_data)
      @data_pack = Factory(:data_pack, :workflow_state => 'sent')
      @client = Client.new( :task => @task, :data_pack => @data_pack)
      @client.instance_variable_set(:@available, false)
      @client.instance_variable_set(:@number, 13)
      @client.terminate
    end

    it 'sets client to unavailable' do
      @client.should_not be_available
    end

    it 'sets client to inactive' do
      @client.should be_inactive
    end

    it 'sets data_pack to waiting' do
      @data_pack.should be_waiting
    end
  end

  describe '#back_to_live' do
    before :each do
      @client = Client.new( :task => @task )
      @client.instance_variable_set(:@available, false)
      @client.instance_variable_set(:@inactive, true)
      @client.back_to_life
    end
    
    it 'sets client to available' do
      @client.should be_available
    end

    it 'sets client to active' do
      @client.should_not be_inactive
    end
  end
end
