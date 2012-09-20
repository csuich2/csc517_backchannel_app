class Category < ActiveRecord::Base
  has_many :posts, :dependent => :delete_all, :validate => :false

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }

  # Search for posts in a given category
  def self.search(category_id)
    Post.all(:conditions => ['category_id = ?', category_id])
  end
end
