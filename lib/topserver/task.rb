class Task < ActiveRecord::Base
  has_many :clients
  has_many :data_packs

  include Workflow

  workflow do
    state :working do
      event :close, :transitions_to => :closed
    end
    state :closed
  end

  attr_accessor :recieved, :timeouted, :extension

  validates_presence_of :name

  before_create :setup_task

  def get_data
    if timeouted.size > 0
      timeouted.pop
    else
      data = nil
      unless end_of_data
        data = extension.read(counter)
        end_of_data = true if data.nil?
      end
      if data
        data_packs << DataPack.create(:data => data)
        increment_counter(data)
        [data, counter - 1]
      else
        nil
      end
    end
  end

  def write_data(data, counter)
    Result.create({:data => data })
    increment_recieved
  end

  def close_task
    Result.all.each do |res|
      extension.write(res.data)
    end
    extension.close_output
    close!
  end

  def completed?
    !closed? && @end_of_data && @counter != 0 && @recieved == @counter
  end

  def add_timeouted_data(data, number) 
    timeouted << [data,number] 
  end

protected

  def setup_task
    self.timeout = 3
    @end_of_data = false
    @timeouted = []
  end

  def timeouted
    @timeouted ||= []
  end

  def extension
    @extension ||= extension_name.constantize.new(source, output,nil)
  end

  def recieved
    @recieved ||= 0
  end

  def increment_counter(data)
    self.counter += data.size
    save
  end

  def increment_recieved
    @recieved = recieved + 1
  end
end
