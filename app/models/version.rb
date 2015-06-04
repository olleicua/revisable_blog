class Version < ActiveRecord::Base
  belongs_to :post
  has_one :user, through: :post
end
