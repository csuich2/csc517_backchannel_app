require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create

  attr_accessible :username, :password, :password_confirmation, :is_admin

  def self.authenticate(username="", login_password="")
    user = User.find_by_username(username)

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
    encrypted_password == Digest::SHA1.hexdigest(login_password)
  end

  def encrypt_password
    unless password.blank?
      self.encrypted_password = Digest::SHA1.hexdigest(password)
    end
  end

  def clear_password
    self.password = nil
  end
end
