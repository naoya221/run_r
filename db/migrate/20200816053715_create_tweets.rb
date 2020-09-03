class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :content,        null: false
      t.string :prefecture,     null: false
      t.string :city,           null: false
      t.string :address
      t.string :place_name,     null: false
      t.string :place_image,    null: false
      t.references :user,       null: false,   foreign_key: true
      t.timestamps
    end
  end
end
