class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.integer  "user_id"
      t.integer  "comment_id"
      t.timestamps
    end
  end
end