class TaskLoader
  def self.load(server)
    tasks_config = YAML::load(File.open("config/tasks.yml"))
    tasks_config.each do |conf|
      server.tasks << Task.new(:name => conf[0], 
          :file_extension => BinaryFileExtension.new(
            conf[1]["source"], conf[1]["output"], conf[1]["delimeter"]))
    end
  end
end
