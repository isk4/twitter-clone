class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, dependent: :destroy

  def to_s
    self.username
  end

  def follows?(user)
    self.friends.where(friend_id: user.id).present?
  end

  def get_follow_id(user)
    self.friends.where(friend_id: user.id).ids
  end
end
