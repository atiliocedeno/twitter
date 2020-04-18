class AddRetweetsToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :retweets, :integer, default: 0
  end
end
