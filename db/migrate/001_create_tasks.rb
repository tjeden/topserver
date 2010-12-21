class CreateTasks < ActiveRecord::Migration

  def self.up
    create_table :tasks do |t|
      t.string :name, :null => false
      t.string :workflow_state, :null => false
      t.string :source
      t.string :output
      t.integer :timeout
      t.boolean :end_of_data
    end
  end
   
  def self.down
    drop_table :tasks
  end
end


