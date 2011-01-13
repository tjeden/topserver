class Client < ActiveRecord::Base
  belongs_to :task
  belongs_to :data_pack

  scope :available, where(:available => true)
  scope :inactive, where(:inactive => true)

  before_create :setup_client

  def send_task
    data = @task.get_data
    if data
      update_attribute(:available, false)
      update_attribute(:send_at, Time.now)
      update_attribute(:data_pack_id, data.id)
      data.send_to_client!
      EM.connect(ip, port, Sender, data.input_data) do |server|
        server.callback {
        }
      end
    end
  end

  def receive_task(data)
    data_pack.update_attribute(:output_data, data)
    data_pack.recieve!
    task.write_data(data, number) if !@number.nil?
    update_attribute(:available, true)
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
    data_pack.terminate!
    self.inactive = true
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
  
  def setup_client
    self.available = true
    self.port ||= "80"
  end
end
