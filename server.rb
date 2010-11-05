class Server

  attr_accessor :clients, :tasks

  def initialize
    @clients = []
    @tasks = []
  end

  def start
  end

  def register_client(opts={})
    task = find_task_by_name(opts[:task_name])
    clients << Client.new( :ip => opts[:ip], :task => task)
  end

  private
  def find_task_by_name(name)
    tasks.find{ |t| t.name == name }
  end
end
