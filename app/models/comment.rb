class Comment < ActiveRecord::Base
  belongs_to :post

  attr_accessible :owner_id, :post_id, :text

  validates :text,  :presence => true
end
