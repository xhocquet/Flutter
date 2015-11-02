class AddTimeCanRefreshToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_can_refresh, :timestamp
  end
end
