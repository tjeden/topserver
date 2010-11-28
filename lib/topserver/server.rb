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

  def diagnose
    log "Available clients #{clients.find_all { |c| c.available? }.size }"
    log "Counter:#{tasks[0].counter} Recieved:#{tasks[0].recieved} Timeouted:#{tasks[0].timeouted.size}"
  end

  def send_tasks_to_clients
    clients.each { |client| client.send_task if client.available? && !client.task.completed?}
  end

  def close_tasks
    tasks.each do |task| 
      if task.completed?
        log 'Task completed'
        task.close_task 
      end
    end
  end

  def check_timeouts
    clients.each_with_index do |client, i|
      if client.terminated? 
        log 'Client lost'
        client.terminate 
        clients.delete_at(i)
      end
    end
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
