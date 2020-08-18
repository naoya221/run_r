class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.references :user,    null: false, foreign_key: true
      t.references :tweet,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
