class AddResponseToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :message, :message_address
   	add_column :users, :presence, :string
    add_column :users, :message_response, :string
  end
end
