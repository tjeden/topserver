require 'spec_helper'

describe FileExtension do
  context 'on create' do
    before :each do
      @ext = FileExtension.new( 'input.txt', 'output.txt', ';')
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

  context 'on read' do
    before :each do
      @ext = FileExtension.new( 'data/dummy_file.txt', 'data/output.txt', ';')
    end

    it 'gets next part of data' do
      @ext.read.should eql('First part')
      @ext.read.should eql('Second part')
      @ext.read.should eql('Third part')
      @ext.read.should eql(nil)
    end
  end

  context 'on write' do
    before :each do
      clean_file('data/output.txt')
      @ext = FileExtension.new( 'data/dummy_file.txt', 'data/output.txt', ';')
      @ext.write('first_line')
      @ext.write('second_line')
      @ext.close_output
    end

    after :each do
      clean_file('data/output.txt')
    end

    it 'writes portion of data' do
      file = File.open('data/output.txt','r') do |file|
        file.gets.should eql("first_line\n")
        file.gets.should eql("second_line\n")
      end
    end

  end
end
