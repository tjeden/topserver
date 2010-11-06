class Client
  attr_accessor :task, :ip, :port

  def initialize(opts={})
    @task = opts[:task]
    @ip = opts[:ip]
    @port = opts[:port] ||= '80'
    @available = true
  end

  def send_task
    puts 'sending'
    @available = false
    data = @task.get_data
    if data
      http = EventMachine::HttpRequest.new("http://#{@ip}:#{@port}").post :query => {'data' => data}, :timeout => 10

      http.callback {
        p http.response_header.status
        p http.response_header
        p http.response

        puts 'sended'
        @available = true
      }
    end
  end

  def available?
    @available
  end
end
