class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  def user_pic_url
    self.user.profile_pic_url
  end
end
