class Post < ActiveRecord::Base
  belongs_to :category

  attr_accessible :owner_id, :text, :title, :category_id

  validates :title, :presence => true, :length => { :in => 3..20 }
  validates :text,  :presence => true
  validates :category_id, :presence => true#, :inclusion => { :in => Category.all(:select => 'id'),
                                            #                 :message => "%{value} is not a valid category id." }

end
