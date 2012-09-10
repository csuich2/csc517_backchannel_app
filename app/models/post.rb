class Post < ActiveRecord::Base
  belongs_to :category

  before_save :set_owner_id

  attr_accessible :owner_id, :text, :title

  validates :title, :presence => true, :length => { :in => 3..20 }
  validates :text,  :presence => true
  validates :category_id, :presence => true, :inclusion => { :in => Category.all(),
                                                             :message => "%{value} is not a valid category id." }

  def set_owner_id
    unless self.owner_id
      self.owner_id = @current_user.id
    end
  end
end
