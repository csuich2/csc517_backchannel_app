require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :comments, :dependent => :delete_all, :validate => :false
  has_many :posts, :dependent => :delete_all, :validate => :false
  has_many :post_votes, :dependent => :delete_all, :validate => :false
  has_many :comment_votes, :dependent => :delete_all, :validate => :false

  before_save :encrypt_password
  after_save :clear_password

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  attr_accessor :password
  attr_accessible :username, :password, :password_confirmation, :is_admin

  # Check a username and password to see if they match a db record
  def self.authenticate(username="", login_password="")
    # Try to find a user
    user = User.find_by_username(username)

    # If a user is found, check the password
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  # Take a password input and hash it to compare it with the password in the db
  def match_password(login_password="")
    encrypted_password == Digest::SHA1.hexdigest(login_password)
  end

  # Encrypted the password for the db
  def encrypt_password
    unless password.blank?
      self.encrypted_password = Digest::SHA1.hexdigest(password)
    end
  end

  # Clear out the plain text password
  def clear_password
    self.password = nil
  end

  # Search for the posts by a user
  def self.search(search)
    search_conditions = "%#{search}%"
    Post.all(:conditions => ['user_id in (SELECT id FROM users where username like ?)', search_conditions])
  end

end
