require 'eventmachine'
require 'trollop'

class DataSender < EM::Connection
  
  attr_accessor :data
  
  def initialize(data, number)
    @data = data
    @number = number
  end
  
  def post_init
    sleep 4
    send_data "RESPONSE #{@number} #{@data}"
  end
  
  def receive_data(data) 
    puts "Response sent"
    close_connection
  end
end

class ClientListener < EM::Connection
  
  attr_accessor :data, :number
  
  def initialize(number)
    @number = number
  end
  
  def post_init
    puts 'Message received'
  end

  def receive_data(data)
    #puts 'receiving'
    @data = data
    send_data('OK')
    close_connection_after_writing
  end
  
  def unbind
    EM.connect("0.0.0.0", 5555, DataSender, @data, @number)
  end
end

class Registerer < EM::Connection
  include EM::Deferrable
  attr_accessor :ip, :port
  
  def initialize(ip, port)
    @ip = ip
    @port =   port
  end
  
  def post_init
    send_data "REGISTER #{@ip} #{@port} foo"
  end
  
  def receive_data(data)
    puts "Registered with number: #{data}"
    close_connection
    EM.start_server(@ip, @port, ClientListener, data)
  end
end

opts = Trollop::options do
  opt :port, "Specify port", :default => 8080         
  opt :ip, "Specify IP", :default => '0.0.0.0' 
end

EM.run{
  puts 'Registering client on server'
  EM.connect('0.0.0.0', 5555, Registerer, opts[:ip], opts[:port]) 
}


