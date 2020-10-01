class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  def like_count
    self.likes.count
  end

  def get_user_id
    self.user.id
  end

  def get_like_id(user)
    self.likes.find_by(user_id: user.id)
  end

  def liked_by?(user)
    self.likes.each do |like|
      return true if like.user == user
    end
    return false
  end
end
