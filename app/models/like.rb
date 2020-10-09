class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: true

  def user_pic_url
    self.user.profile_pic_url
  end
end
