class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts
  has_many :versions, inverse_of: :post
  belongs_to :parent, class_name: 'Version', inverse_of: :comments
  has_many :comments, through: :versions

  accepts_nested_attributes_for :versions

  validates :user_id, presence: true
  validates :latest, presence: true

  def parent_post
    parent.try(:post)
  end

  def self.original
    where('parent_id IS NULL')
  end

  def self.comment
    where('parent_id IS NOT NULL')
  end

  def original?
    parent_id.nil?
  end

  def comment?
    parent_id.present?
  end

  def latest
    versions.order(:time).last
  end

  def cyclic?
    list = [self]
    p = parent_post
    until p.nil?
      return true if list.include? p
      list << p
      p = p.parent_post
    end
    false
  end

  private

  def validate_acyclic
    errors.add(:base, 'Post cannot be cyclic') if cyclic?
  end
  validate :validate_acyclic
end
