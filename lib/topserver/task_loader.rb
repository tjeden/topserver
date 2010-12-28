class TaskLoader
  def self.load
    tasks_config = YAML::load(File.open("config/tasks.yml"))
    tasks_config.each do |conf|
      Task.create!(:name => conf[0], :timeout => conf[1]["timeout"], :source => conf[1]["source"], :output => conf[1]["output"], :extension_name => conf[1]["extension_name"])
    end
  end
end
