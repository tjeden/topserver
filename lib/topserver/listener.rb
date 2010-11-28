class Listener < EM::Connection

  attr_accessor :server

  def post_init
  end

  def receive_data(data)
    splitted_data = data.split
    if splitted_data[0] == "REGISTER"
      server.log 'Registering new client'
      send_data @server.register_client( :ip => splitted_data[1],
        :port => splitted_data[2],
        :task_name => splitted_data[3])
    elsif splitted_data[0] == "RESPONSE" 
#server.log "Received_data from #{splitted_data[1]}"
      client = @server.find_client(splitted_data[1])
      if client
        client.receive_task(data.sub(/RESPONSE \d* /,""))
      else
        @server.log 'non existing client'
      end
      send_data "OK"
    end
  end

  def unbind
  end
end
