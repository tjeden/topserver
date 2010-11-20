class Client
  attr_accessor :task, :ip, :port

  def initialize(opts={})
    @task = opts[:task]
    @ip = opts[:ip]
    @port = opts[:port] ||= '80'
    @available = true
    @number = nil
  end

  def send_task
    @available = false
    data, @number = @task.get_data
    if data
      EM.connect(@ip, @port, Sender, data) do |server|
        server.callback {
        }
      end
    else
      @task.end_writing
    end
  end

  def receive_task(data)
    task.write_data(data, @number)
    @available = true
  end

  def available?
    @available
  end
end
