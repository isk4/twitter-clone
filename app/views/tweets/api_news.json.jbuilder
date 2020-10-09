json.array! @tweets do |tweet|
    json.id tweet.id
    json.content tweet.content
    json.user_id tweet.user_id
    json.likes_count tweet.likes_count
    json.retweets_count tweet.tweets_count
    json.retweeted_from tweet.retweet_from_id
end