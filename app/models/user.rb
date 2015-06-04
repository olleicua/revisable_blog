class User < ActiveRecord::Base
  has_many :posts
  has_many :version, through: :posts
end
