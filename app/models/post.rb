class Post < ApplicationRecord
  validates :timestamp, :title, :content, presence: true
end
