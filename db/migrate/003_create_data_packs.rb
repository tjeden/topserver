class CreateDataPacks < ActiveRecord::Migration

  def self.up
    create_table :data_packs do |t|
      t.integer :task_id
      t.string :workflow_state
      t.text :input_data
      t.text :output_data
    end
  end
   
  def self.down
    drop_table :data_packs
  end
end


