class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: { man: 1, woman: 2 }
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true
  validates :hometown, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :avatar, presence: true

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def matchers
    User.where(id: relationships.select(:follow_id))
     .where(id: reverse_of_relationships.select(:user_id))
  end

  def lovers
    User.where(id: reverse_of_relationships.select(:user_id))
      .where.not(id: relationships.select(:follow_id))
  end

  #mount_uploader :avatar, AvatarUploader
end
