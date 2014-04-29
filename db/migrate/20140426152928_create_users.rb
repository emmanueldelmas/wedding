class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :firstname
    	t.string :lastname
    	t.string :email
    	t.string :login
    	t.string :salt
    	t.string :encrypted_password
    	t.integer :partner_id
    	t.string :street
    	t.string :address_add
    	t.string :town
    	t.string :zip_code
    	t.text :message

      t.timestamps
    end
  end
end
