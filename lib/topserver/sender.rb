class Sender < EM::Connection
  include EM::Deferrable
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def post_init
    puts @data.size
    send_data @data
  end

  def receive_data(data)
  end

  def unbind
    set_deferred_status :succeeded
  end
end
