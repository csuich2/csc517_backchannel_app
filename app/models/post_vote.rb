class PostVote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  attr_accessible :post_id, :user_id

  validates :post_id, :presence => true
  validates :user_id, :presence => true
end