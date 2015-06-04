class Post < ActiveRecord::Base
  belongs_to :user
  has_many :versions
  belongs_to :parent, class_name: 'Post'

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
