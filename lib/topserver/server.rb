class Server 

  attr_accessor :tasks, :clients_history

  def initialize
    @tasks = Task.all
    @clients_history = []
    @logger = TopserverLogger.new
    @max_client_number = 0
  end

  def register_client(opts={})
    if (task = find_task_by_name(opts[:task_name]))
      @max_client_number += 1
      Client.create( :ip => opts[:ip], :task => task, :port => opts[:port], :number => @max_client_number)
      update_clients_history
      @max_client_number
    else
      -1
    end
  end

  def find_client(number)
    Client.find_by_number(number.to_i)
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
        update_clients_history
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

  def update_clients_history
    @clients_history << [Time.now, active_clients]
  end

  def active_clients
    clients.find_all { |c| c.active? }.size
  end

  private
  def find_task_by_name(name)
    tasks.find{ |t| t.name == name }
  end

  def clients
    Client.all
  end

end
