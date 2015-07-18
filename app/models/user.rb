class User < ActiveRecord::Base
  has_many :posts, inverse_of: :user
  has_many :versions, through: :posts, inverse_of: :user

  validates :username, presence: true

  def self.ufind(username)
    ret = find_by username: username
    if ret.nil?
      raise ActiveRecord::RecordNotFound,
            "Couldn't find User with 'username'=#{username}"
    end
    ret
  end

  def to_param
    username
  end
end
