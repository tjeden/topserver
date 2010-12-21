class TaskLoader
  def self.load
    tasks_config = YAML::load(File.open("config/tasks.yml"))
    tasks_config.each do |conf|
      #File extenson should be in config and done using constantize
      if conf[1]["binary"]
        file_extension = BinaryFileExtension.new( conf[1]["source"], conf[1]["output"], conf[1]["delimeter"])
      else
        file_extension = FileExtension.new( conf[1]["source"], conf[1]["output"], conf[1]["delimeter"])
      end
      Task.create!(:name => conf[0], :timeout => conf[1]["timeout"], :file_extension => file_extension, :source => conf[1]["source"], :output => conf[1]["output"])
    end
  end
end
