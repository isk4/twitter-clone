json.tweet do
    json.username @tweet.user.username
    json.content @tweet.content
    json.created_at @tweet.created_at.to_s
end