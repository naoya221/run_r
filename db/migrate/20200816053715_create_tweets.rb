class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :content,        null: false
      t.string :address,        null: false
      t.float  :latitude
      t.float  :longitude
      t.string :place_name,     null: false
      t.string :place_image,    null: false
      t.references :user,       null: false,   foreign_key: true
      t.timestamps
    end
    add_index :tweets, [:user_id, :created_at]
  end
end
