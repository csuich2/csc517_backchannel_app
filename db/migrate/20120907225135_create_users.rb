class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :username
        t.string :encrypted_password
        t.boolean :is_admin, :default => false
    end
  end
end
