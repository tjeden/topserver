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
      xit 'is false' do
        @task.stub!(:end_of_data).and_return(false)
        @task.completed?.should be_false 
      end
    end

    context 'when there are not any data' do
      xit 'is true' do
        @task.stub!(:end_of_data).and_return(true)
        @task.completed?.should be_true
      end
    end

    context 'when task is closed and there are not any data' do
      xit 'is false' do
        @task.stub!(:closed?).and_return(true)
        @task.stub!(:end_of_data).and_return(true)
        @task.completed?.should be_false 
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
