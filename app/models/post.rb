class Post < ActiveRecord::Base
  belongs_to :user
  has_many :versions
  belongs_to :parent, class_name: 'Post'
end
