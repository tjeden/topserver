class Client < ActiveRecord::Base
  belongs_to :task

  attr_accessor :data

  before_create :set_client_available
  validates_uniqueness_of :number

  def send_task
    update_attribute(:available, false)
    update_attribute(:send_at, Time.now)
    @data, self.number = @task.get_data
    self.save
    if data
      EM.connect(ip, port, Sender, @data) do |server|
        server.callback {
        }
      end
    end
  end

  def receive_task(data)
    task.write_data(data, number) if !@number.nil?
    available = true
    save
  end

  def available?
    self.available && !inactive
  end

  def inactive?
    inactive
  end

  def active?
    !inactive
  end

  def terminate
    @task.add_timeouted_data(@data, @number)
    self.inactive = true
    self.number = nil
    save
  end

  def terminated?
    self.active? && !self.send_at.nil? && !self.available? && (Time.now - self.send_at > task.timeout ) 
  end

  def back_to_life
    self.available = true
    self.inactive = false
    save
  end

protected
  
  def data
    @data ||= []
  end

  def set_client_available
    update_attribute(:available, true)
  end
end
