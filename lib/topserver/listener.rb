class Listener < EM::Connection
  include EM::HttpServer

  def post_init
    puts "-- someone connected to the echo server!"
  end

  def receive_data(data)
    puts data
    send_data ">>>you sent: #{data}"
    close_connection_after_writing if data =~ /quit/i
  end

  def unbind
    puts "-- someone disconnected from the echo server!"
  end
end
