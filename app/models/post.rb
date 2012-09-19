class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments, :dependent => :delete_all, :validate => :false
  has_many :post_votes, :dependent => :delete_all, :validate => :false

  attr_accessible :text, :title
  attr_accessible :category_id, :user_id

  validates :title, :presence => true, :length => { :in => 3..20 }
  validates :text,  :presence => true
  validates :category_id, :presence => true
  validates :user_id, :presence => true


  def self.search(search)
    search_conditions = "%#{search}%"
    all(:conditions => ['title like ? OR text like ?', search_conditions, search_conditions])
  end

  def latest_timestamp

    # Retrieving the latest "updated_at" timestamps for the Posts
    # Finding out updated_at values for Vote on the Post, Comment on the Post, Vote on the Comment related to the Post

    comment = Comment.order("updated_at DESC").find_all_by_post_id(self.id, :limit => 1).first
    comment_timestamp = comment ? comment.updated_at : Time.at(0)

    post_vote = PostVote.order("updated_at DESC").find_all_by_post_id(self.id, :limit => 1).first
    post_vote_timestamp = post_vote ? post_vote.updated_at : Time.at(0)

    comment_vote = CommentVote.order("updated_at DESC").all(:conditions => "comment_id in (SELECT id FROM comments WHERE post_id = #{self.id})").first
    comment_vote_timestamp = comment_vote ? comment_vote.updated_at : Time.at(0)

    #Finding out the most updated value from the below 4 and sorting the Posts based on which is the most recent one
    [self.updated_at, comment_timestamp, post_vote_timestamp, comment_vote_timestamp].max { |a, b| a <=> b }
  end

end
