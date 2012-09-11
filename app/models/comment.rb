class Comment < ActiveRecord::Base
  belongs_to :post

  before_save :set_owner_id

  attr_accessible :owner_id, :post_id, :text

  validates :text,  :presence => true

  def set_owner_id
    unless self.owner_id
      self.owner_id = @current_user.id
    end
  end
end
