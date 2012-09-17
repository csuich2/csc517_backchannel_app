class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :post_votes, :dependent => :delete_all, :validate => :false

  attr_accessible :text, :title
  attr_accessible :category_id, :user_id

  validates :title, :presence => true, :length => { :in => 3..20 }
  validates :text,  :presence => true
  validates :category_id, :presence => true
  validates :user_id, :presence => true
end
