class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts
  has_many :versions, inverse_of: :post
  belongs_to :parent, class_name: 'Post', inverse_of: :comments
  has_many(:comments, class_name: 'Post',
           foreign_key: 'parent_id',
           inverse_of: :parent)

  accepts_nested_attributes_for :versions

  validates :user_id, presence: true

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

  private

  def cyclic?
    list = [self]
    p = parent
    until p.nil?
      return true if list.include? p
      list << p
      p = p.parent
    end
    false
  end

  def validate_acyclic
    errors.add(:base, 'Post cannot be cyclic') if cyclic?
  end
  validate :validate_acyclic
end
