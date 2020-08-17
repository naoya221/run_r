class AddUserIdToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :user_id, :integer
  end
end
