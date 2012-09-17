class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  attr_accessible :text
  attr_accessible :post_id, :user_id

  validates :text,  :presence => true
  validates :post_id, :presence => true
  validates :user_id, :presence => true

  after_validation :log_errors, :if => Proc.new {|m| m.errors}

  def log_errors
    Rails.logger.debug self.errors.full_messages.join("\n")
  end
end
