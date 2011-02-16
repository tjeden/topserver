require 'spec_helper'

describe Task do
  describe '#on create' do
    before :each do
      @task = Task.create( :name => 'foo')
    end

    it 'assigns name' do
      @task.name.should eql('foo')
    end

    it 'is incomplete' do
      @task.completed?.should be_false
    end

    it 'is working' do
      @task.working?.should be_true
    end

  end

  describe '#completed?' do
    before :each do
      @task = Task.new( :name => 'foo')
    end

    context 'when there are data' do
      before :each do
        @task.end_of_data = false
      end

      it 'is false' do
        @task.completed?.should be_false 
      end
    end

    context "when there aren't left data" do
      before :each do
        @task.end_of_data = true
      end

      context 'and there are waiting data_packs' do
        it 'is false' do
          @task.data_packs << Factory(:data_pack, :workflow_state => 'waiting')
          @task.completed?.should be_false
        end
      end

      context 'and there arent counter is eql with recieved' do
        it 'is true' do
          @task.completed?.should be_true
        end
      end
    end
  end

  describe '#close_task' do
    before :each do
      @task = Task.new( :name => 'foo')
    end

    it 'closes task and file' do
      fe = stub() 
      @task.instance_variable_set(:@extension, fe)
      @task.should_receive(:close)
      @task.close_task
    end
  end

end
