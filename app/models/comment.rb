class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :comment_votes, :dependent => :delete_all, :validate => :false

  attr_accessible :text
  attr_accessible :post_id, :user_id

  validates :text,  :presence => true
  validates :post_id, :presence => true
  validates :user_id, :presence => true

  after_validation :log_errors, :if => Proc.new {|m| m.errors}

  def log_errors
    Rails.logger.debug self.errors.full_messages.join("\n")
  end

  def latest_timestamp

    comment_vote = CommentVote.order("updated_at DESC").all(:conditions => "comment_id in (SELECT id FROM comments WHERE id = #{self.id})").first
    comment_vote_timestamp = comment_vote ? comment_vote.updated_at : Time.at(0)

    [self.updated_at, comment_vote_timestamp].max { |a, b| a <=> b }
  end
end
