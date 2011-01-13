class ChangeDatesInDatapack < ActiveRecord::Migration

  def self.up
    rename_column :data_packs, :recieve_date, :recieved_at
    rename_column :data_packs, :send_date, :send_at
  end
   
  def self.down
    rename_column :data_packs, :recieved_at, :recieve_date
    rename_column :data_packs, :send_at, :send_date
  end
end


