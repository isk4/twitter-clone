json.array! @tweets do |tweet|
    json.id tweet.id
    json.user_id tweet.user_id
    json.like_count tweet.like_count
    json.retweets_count tweet.retweet_count
    json.retweeted_from tweet.retweet_from_id
end