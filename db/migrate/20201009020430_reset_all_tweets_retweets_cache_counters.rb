class ResetAllTweetsRetweetsCacheCounters < ActiveRecord::Migration[5.2]
  def change
    Tweet.all.each do |tweet|
      Tweet.reset_counters(tweet.id, :tweets)
    end
  end
end
