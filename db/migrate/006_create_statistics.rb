class CreateStatistics < ActiveRecord::Migration

  def self.up
    create_table :statistics do |t|
      t.integer :task_id, :null => false
      t.datetime :updated_at
      t.integer :clients_total
      t.integer :available_clients
      t.integer :inactive_clients
      t.integer :active_clients
    end
  end
   
  def self.down
    drop_table :statistics
  end
end


