class Tweet < ApplicationRecord
  has_many :likes
  has_many :users, through: :likes
  validates :content, presence: true
  belongs_to :user
  has_and_belongs_to_many :tags 
  
  after_create do
    tweet = Tweet.find_by(id: self.id)
    hashtag = self.content.scan(/#\w+/)
    hashtag.uniq.map do |h|
    tag = Tag.find_or_create_by(name: h.downcase.delete('#'))
    tweet.tags << tag
    end
  end
before_update do
    tweet = Tweet.find_by(id: self.id)
    tweet.tags.clear
    hashtag = self.content.scan(/#\w+/)
hashtag.uniq.map do |h|
    tag = Tag.find_or_create_by(name: h.downcase.delete('#'))
    tweet.tags << tag
  end
end

end
