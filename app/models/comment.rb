class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  attr_accessible :text
  attr_accessible :post_id, :user_id

  validates :text,  :presence => true
end
