class Version < ActiveRecord::Base
  belongs_to :post, inverse_of: :versions
  has_one :user, through: :post, inverse_of: :versions

  validates :post_id, presence: true

  def to_param
    "#{id}-#{title}"
  end

  private

  def set_time
    self.time = DateTime.current if time.nil?
  end
  before_create :set_time
end
