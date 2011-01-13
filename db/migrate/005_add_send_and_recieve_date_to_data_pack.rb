class AddSendAndRecieveDateToDataPack < ActiveRecord::Migration

  def self.up
    add_column :data_packs, :send_date, :datetime
    add_column :data_packs, :recieve_date, :datetime
  end

  def self.down
    remove_column :data_pakcs, :send_date
    remove_column :data_pakcs, :recieve_date
  end
end
