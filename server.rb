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
        puts i
        sleep 1
      end
    end
  end

  def stop
    @running = false
  end

  def running?
    @running
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
