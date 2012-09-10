class Category < ActiveRecord::Base
  has_many :posts

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
end
