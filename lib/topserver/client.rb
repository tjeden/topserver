class Sender < EM::Connection
  include EM::Deferrable
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def post_init
    puts 'sending'
    send_data @data
  end

  def receive_data(data)
    puts "response: #{data}"
  end

  def unbind
    set_deferred_status :succeeded
  end
end

class Client
  attr_accessor :task, :ip, :port

  def initialize(opts={})
    @task = opts[:task]
    @ip = opts[:ip]
    @port = opts[:port] ||= '80'
    @available = true
  end

  def send_task
    @available = false
    data = @task.get_data
    if data
      puts '=start data'
      puts data.size
      puts '=end data'
      EM.connect(@ip, @port, Sender, data) do |server|
        server.callback {
          @available = true
        }
      end
    else
      @task.end_writing
    end
  end

  def receive_task(data)
    task.write_data(data)
  end

  def available?
    @available
  end
end
