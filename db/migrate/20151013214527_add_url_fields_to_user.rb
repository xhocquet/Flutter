class AddUrlFieldsToUser < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.string :hm_dash_url
      u.string :hm_library_url
    end
  end
end
