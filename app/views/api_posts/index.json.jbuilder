json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content
  json.timestamp "#{post.timestamp} 00:00:00"
end
