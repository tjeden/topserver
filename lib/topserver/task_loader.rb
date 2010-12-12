class TaskLoader
  def self.load(server)
    server.tasks << Task.new(:name => 'foo', :file_extension => BinaryFileExtension.new('data/owles.jpg', 'data/output.jpg', ';'))
  end
end
