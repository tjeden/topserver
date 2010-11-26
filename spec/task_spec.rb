require 'spec_helper'

describe Task do
  describe '#on create' do
    before :each do
      @task = Task.new( :name => 'foo')
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
        @task.instance_variable_set(:@end_of_data, false)
      end

      it 'is false' do
        @task.completed?.should be_false 
      end
    end

    context "when there aren't any data" do
      before :each do
        @task.instance_variable_set(:@end_of_data, true)
      end

      context 'and counter is eql 0' do
        before :each do
          @task.instance_variable_set(:@counter,0)
        end
        
        it 'is false' do
          @task.completed?.should be_false
        end
      end

      context 'and counter is diffrent from 0' do
        before :each do
          @task.instance_variable_set(:@counter, 2)
        end
        
        context 'and counter is diffrent from recieved' do
          it 'is false' do
            @task.instance_variable_set(:@recieved, 1)
            @task.completed?.should be_false
          end
        end

        context 'and counter is eql with recieved' do
          it 'is true' do
            @task.instance_variable_set(:@recieved, 2)
            @task.completed?.should be_true
          end
        end
      end

    end
  end

  describe '#close_task' do
    before :each do
      @task = Task.new( :name => 'foo')
    end

    xit 'spec close task' do
    end
  end
end
