class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  def like_count
    self.likes.count
  end

  def get_user_id
    self.user.id
  end
end
