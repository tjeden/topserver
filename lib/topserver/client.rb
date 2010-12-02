class Client
  attr_accessor :task, :ip, :port, :data, :client_number, :inactive

  def initialize(opts={})
    @task = opts[:task]
    @ip = opts[:ip]
    @port = opts[:port] ||= '80'
    @client_number = opts[:client_number]
    @available = true
    @number = nil
    @data = nil
  end

  def send_task
    @available = false
    @send_at = Time.now
    @data, @number = @task.get_data
    if data
      EM.connect(@ip, @port, Sender, @data) do |server|
        server.callback {
        }
      end
    end
  end

  def receive_task(data)
    task.write_data(data, @number) if !@number.nil?
    @available = true
  end

  def available?
    @available && !@inactive
  end

  def inactive?
    @inactive
  end

  def terminate
    @task.add_timeouted_data(@data, @number)
    @inactive = true
    @number = nil
  end

  def terminated?
    !@send_at.nil? && !available? && (Time.now - @send_at > task.timeout )
  end
end
