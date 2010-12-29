class AddDataPackIdToClient < ActiveRecord::Migration

  def self.up
    add_column :clients, :data_pack_id, :integer
  end

  def self.down
    remove_column :clients, :data_pack_id
  end
end
