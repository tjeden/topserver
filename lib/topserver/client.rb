class Client
  attr_accessor :task, :ip

  def initialize(opts={})
    @task = opts[:task]
    @ip = opts[:ip]
    @available = true
  end

  def send_task
    @available = false
  end

  def available?
    @available
  end
end
