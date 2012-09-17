class CommentVote < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user

  attr_accessible :comment_id, :user_id

  validates :comment_id, :presence => true
  validates :user_id, :presence => true
end
