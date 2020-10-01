class Tweet < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  has_many :likes, dependent: :destroy

  def self.get_tweets(amount, page)
    self.offset(amount * (page - 1)).limit(amount)
  end

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
