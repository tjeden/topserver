# coding: utf-8
class Task < ActiveRecord::Base
  has_many :clients
  has_many :data_packs
  has_many :statistics

  include Workflow

  workflow do
    state :working do
      event :close, :transitions_to => :closed
    end
    state :closed
  end

  attr_accessor :extension

  validates_presence_of :name, :extension_name, :message => "nie może być puste"
  validates_numericality_of :timeout, :greater_than => 0, :message => "musi być liczbą wiekszą od 0", :if => Proc.new { |t| t.timeout.present? }

  before_create :setup_task

  def get_data
    if timeouted.present?
      timeouted.first
    else
      data = nil
      unless end_of_data
        data = extension.read(counter)
        update_attribute(:end_of_data, true) if data.nil?
      end
      if data
        increment_counter(data)
        data_packs.create(:input_data => data)
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
    #data_packs.each { |dp| extension.write(dp.output_data)}
    #extension.close_output
    close!
  end

  def completed?
    !closed? && self.end_of_data && data_packs.all?{ |d| d.workflow_state == "recieved" }
  end

  def timeouted
    data_packs.find_all_by_workflow_state("waiting")
  end

  def update_statistics
    statistics.create( :clients_total => clients_total, :active_clients => active_clients, :available_clients => available_clients, :inactive_clients  => inactive_clients)
  end

protected

  def setup_task
    self.timeout ||= 3
    @end_of_data = false
    @timeouted = []
  end

  def extension
    @extension ||= extension_name.constantize.new(source, output,nil)
  end

  def increment_counter(data)
    self.counter += @extension.counter_size(data)
    save
  end

  def clients_total
    clients.size 
  end

  def active_clients
    clients.find_all { |c| c.active? }.size
  end

  def available_clients
    clients.available.size
  end

  def inactive_clients
    clients.inactive.size
  end
end
