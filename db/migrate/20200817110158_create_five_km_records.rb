class CreateFiveKmRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :five_km_records do |t|
      t.integer      :minute_id
      t.integer      :second_id
      t.references   :user,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
