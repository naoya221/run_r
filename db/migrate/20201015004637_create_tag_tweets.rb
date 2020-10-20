class CreateTagTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_tweets do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tag_tweets, [:tweet_id, :tag_id], unique: true
  end
end
