class Tweet < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  has_many :likes, dependent: :destroy
  belongs_to :tweets, optional: true
  has_many :tweets, foreign_key: "retweet_from_id", dependent: :destroy

  def self.get_tweets(amount, page)
    self.order(id: :desc).offset(amount * (page - 1)).limit(amount)
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

  def retweet_from
    Tweet.find(self.retweet_from_id)
  end

  def retweet_count
    self.tweets.count
  end

  def retweeted_by?(user)
    self.tweets.each do |tweet|
      return true if tweet.user == user
    end
    return false
  end
end
