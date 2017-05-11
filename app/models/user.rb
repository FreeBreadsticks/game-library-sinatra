class User < ActiveRecord::Base
  has_secure_password
  has_many :games

  validates :username, presence: true, uniqueness: true

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    unslug = slug.gsub("-", " ").downcase
    User.find_by(:username => unslug)
  end

end
