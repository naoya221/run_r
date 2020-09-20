class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.references :user,    null: false, foreign_key: true
      t.references :tweet,   null: false, foreign_key: true
      t.timestamps
    end
    add_index :messages, [:user_id, :tweet_id, :created_at]
  end
end
