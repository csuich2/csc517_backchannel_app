class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments

  attr_accessible :owner_id, :text, :title, :category_id

  validates :title, :presence => true, :length => { :in => 3..20 }
  validates :text,  :presence => true
  validates :category_id, :presence => true#, :inclusion => { :in => Category.all(:select => 'id').collect(),
                                            #                 :message => "%{value} is not a valid category id." }
end
