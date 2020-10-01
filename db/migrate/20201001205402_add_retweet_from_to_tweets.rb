class AddRetweetFromToTweets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :retweet_from, foreign_key: { to_table: :tweets }
  end
end
