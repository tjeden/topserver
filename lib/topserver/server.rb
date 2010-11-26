class Server 

  attr_accessor :clients, :tasks

  def initialize
    @clients = []
    @tasks = []
    @logger = Logger.new
  end

  def register_client(opts={})
    task = find_task_by_name(opts[:task_name])
    clients << Client.new( :ip => opts[:ip], :task => task, :port => opts[:port])
    clients.size - 1
  end

  def find_client(number)
    clients[number.to_i]
  end

  def send_tasks_to_clients
    clients.each { |client| client.send_task if client.available? && !client.task.completed?}
  end

  def close_tasks
    tasks.each { |task| task.close_task if task.completed? }
  end

  def log(message)
    logger.info(message) if logging?
  end

  def logging?
    true unless defined?(TEST_ENV)
  end

  def logger
    @logger
  end

  private
  def find_task_by_name(name)
    tasks.find{ |t| t.name == name }
  end
end
