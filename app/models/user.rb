class User < ActiveRecord::Base
  has_many :posts, inverse_of: :user
  has_many :versions, through: :posts, inverse_of: :user

  validates :username, presence: true

  def self.ufind(username)
    ret = find_by_username username
    raise ActiveRecord::RecordNotFound,
          "Couldn't find User with 'username'=#{username}"
  end

  def to_param
    username
  end
end
