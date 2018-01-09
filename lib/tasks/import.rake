require 'csv'
require 'open-uri'
require 'json'
namespace :import do
  desc "Imports posts from old admin site"
  task posts: :environment do
    url = 'http://lf-app.cgrune.com/api/posts'
    parsed_data = JSON.parse(open(url).read)
    parsed_data.each do |item|
      p = Post.new
      p.title = item['title']
      p.timestamp = item['timestamp']
      p.content = item['content']
      p.save
    end
  end
end
