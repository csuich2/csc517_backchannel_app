class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :title
      t.text    :text
      t.integer :owner_id
      t.integer :category_id

      t.timestamps
    end
  end
end
