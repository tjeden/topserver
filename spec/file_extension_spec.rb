require 'spec_helper'

describe FileExtension do
  context 'on create' do
    before :each do
      @ext = FileExtension.new( 'Foo', 'input.txt', 'output.txt', ';')
    end

    it 'sets task type' do
      @ext.task_type.should eql('Foo')
    end

    it 'sets input file' do
      @ext.input_file.should eql('input.txt')
    end

    it 'sets output file' do
      @ext.output_file.should eql('output.txt')
    end

    it 'sets delimeter' do
      @ext.delimeter.should eql(';')
    end
  end

  context 'on get_portion' do
    before :each do
    end

    it 'gets next line of file' do
    end
  end
end
