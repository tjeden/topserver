class Client
  attr_accessor :task, :ip

  def initialize(opts={})
    @task = opts[:task]
    @ip = opts[:ip]
  end
end
