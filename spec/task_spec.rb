require 'spec_helper'

describe Task do
  describe '#on create' do
    before :each do
      @task = Task.new( :name => 'foo')
    end

    it 'assigns name' do
      @task.name.should eql('foo')
    end
  end
end
