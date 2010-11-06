class Server

  attr_accessor :clients, :tasks

  def initialize
    @clients = []
    @tasks = []
  end

  def start
    @running = true    
    Thread.new do
      while(running?)
        send_tasks_to_clients
        sleep 1
      end
    end
  end

  def stop
    @running = false
  end

  def running?
    @running == true
  end

  def register_client(opts={})
    task = find_task_by_name(opts[:task_name])
    clients << Client.new( :ip => opts[:ip], :task => task)
  end

  def send_tasks_to_clients
    clients.each do |client|
      client.send_task if client.available?
    end
  end

  private
  def find_task_by_name(name)
    tasks.find{ |t| t.name == name }
  end
end
