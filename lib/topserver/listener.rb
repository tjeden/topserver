class Listener < EM::Connection

  attr_accessor :server

  def post_init
#puts "-- someone connected to the echo server!"
  end

  def receive_data(data)
    splitted_data = data.split
    if splitted_data[0] == "REGISTER"
      puts 'Registering new client'
      send_data @server.register_client( :ip => splitted_data[1],
        :port => splitted_data[2],
        :task_name => splitted_data[3])
    elsif splitted_data[0] == "RESPONSE" 
      puts "Received_data from #{splitted_data[1]}"
      @server.find_client(splitted_data[1]).receive_task(data.sub(/RESPONSE \d* /,""))
      send_data "OK"
    end
  end

  def unbind
#    puts "-- someone disconnected from the echo server!"
  end
end
