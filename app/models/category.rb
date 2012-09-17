class Category < ActiveRecord::Base
  has_many :posts

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }

  def self.search(category_id)
    Post.all(:conditions => ['category_id = ?', category_id])
  end
end
