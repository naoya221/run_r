class AddLevelToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :level, :integer
  end
end
