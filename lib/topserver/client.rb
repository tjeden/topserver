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
      puts '=start'
      puts data.size
      puts '=end'
      http = EventMachine::Protocols::HttpClient.request(
        :host => @ip,
        :port => @port,
        :request => '/',
        :content => data,
        :contenttype => 'application/octet-stream',
        :verb => 'post'
      )
      http.callback {|response|
        puts response[:status]
      }

    end
  end

  def available?
    @available
  end
end
