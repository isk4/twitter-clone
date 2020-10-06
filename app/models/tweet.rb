class Tweet < ApplicationRecord
  belongs_to :user
  validates  :content , presence:    true
  has_many   :likes   , dependent:   :destroy
  belongs_to :tweets  , optional:    true
  has_many   :tweets  , foreign_key: "retweet_from_id", dependent: :destroy
  
  scope :desc          , -> { order(id: :desc) }
  scope :tweets_for_me , -> (friends_list) { where(user_id: (friends_list.map { |friend| friend.friend_id } << friends_list[0].user_id)) }
  scope :page          , -> (page) { offset(50 * (page - 1)).limit(50) }
  scope :search_for    , -> (search) { where("lower(content) LIKE ?", "%#{search}%".downcase) }

  def split_content
    self.content.split(" ")
  end
  
  def get_hashtags
    self.split_content.select { |word| word.match(/\A#[a-zA-Z0-9]+\z/) }
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
