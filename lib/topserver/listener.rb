class Listener < EM::Connection

  attr_accessor :server

  def post_init
    puts "-- someone connected to the echo server!"
  end

  def receive_data(data)
    port, ip = Socket.unpack_sockaddr_in(get_peername)
    splitted_data = data.split
    if splitted_data[0] == "REGISTER"
      @server.register_client( :ip => ip,
        :port => port,
        :task_name => splitted_data[3])
    elsif splitted_data[0] == "RESPONSE"
      @server.find_client(port, ip).receive_task(data.sub("RESPONSE ",""))
    end
    send_data "OK"
  end

  def unbind
    puts "-- someone disconnected from the echo server!"
  end
end
