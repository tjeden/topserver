class Server 

  attr_accessor :clients, :tasks

  def initialize
    @clients = []
    @tasks = []
  end

  def register_client(opts={})
    task = find_task_by_name(opts[:task_name])
    clients << Client.new( :ip => opts[:ip], :task => task, :port => opts[:port])
    clients.size - 1
  end

  def send_tasks_to_clients
    clients.each do |client|
      client.send_task if client.available?
    end
  end

  def find_client(number)
    clients[number.to_i]
  end

  private
  def find_task_by_name(name)
    tasks.find{ |t| t.name == name }
  end
end
