class Version < ActiveRecord::Base
  belongs_to :post, inverse_of: :versions
  has_one :user, through: :post, inverse_of: :versions
  has_many(:comments, class_name: 'Post',
           foreign_key: 'parent_id',
           inverse_of: :parent)

  validates :post_id, presence: true

  def to_param
    "#{id}-#{title.downcase.parameterize}"
  end

  def other_versions
    post.versions.where('id != ?', self.id)
  end

  def earlier_versions
    other_versions.where('time < ?', time)
  end

  def later_versions
    other_versions.where('time > ?', time)
  end

  private

  def set_time
    self.time = DateTime.current if time.nil?
  end
  before_create :set_time
end
