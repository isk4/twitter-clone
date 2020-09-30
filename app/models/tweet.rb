class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes

  def like_count
    self.likes.count
  end
end
