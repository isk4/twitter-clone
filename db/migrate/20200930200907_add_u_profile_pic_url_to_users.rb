class AddUProfilePicUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_pic_url, :string, null: false
  end
end
