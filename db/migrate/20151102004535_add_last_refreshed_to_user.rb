class AddLastRefreshedToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_last_refreshed, :time
  end
end
