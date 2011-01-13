class DataPack < ActiveRecord::Base
  belongs_to :task
  has_one :client

  include Workflow

  workflow do
    state :waiting do
      event :send_to_client, :transitions_to => :sent
    end
    state :sent do
      event :recieve, :transitions_to => :recieved
      event :terminate, :transitions_to => :waiting
    end
    state :recieved
  end

  def send_to_client
    update_attribute(:send_date, Time.now)
  end

  def recieve
    update_attribute(:recieve_date, Time.now)
  end
end
