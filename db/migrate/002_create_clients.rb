class CreateClients < ActiveRecord::Migration

  def self.up
    create_table :clients do |t|
      t.integer :task_id
      t.string :ip
      t.string :port
      t.integer :number
      t.datetime :send_at
      t.boolean :available, :default => true
      t.boolean :inactive, :default => false
    end
  end
   
  def self.down
    drop_table :clients
  end
end


