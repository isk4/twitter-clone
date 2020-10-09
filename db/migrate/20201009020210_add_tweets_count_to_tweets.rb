class AddTweetsCountToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :tweets_count, :integer, default: 0
  end
end
