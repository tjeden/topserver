class Listener < EM::Connection

  attr_accessor :server

  def post_init
    puts "-- someone connected to the echo server!"
  end

  def receive_data(data)
    splitted_data = data.split
    if splitted_data[0] == "REGISTER"
      @server.register_client( :ip => splitted_data[1], 
        :port => splitted_data[2],
        :task_name => splitted_data[3])
    else
      @server.tasks.first.write_data(data)  
    end
    send_data "OK"
  end

  def unbind
    puts "-- someone disconnected from the echo server!"
  end
end
