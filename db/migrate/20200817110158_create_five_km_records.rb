class CreateFiveKmRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :five_km_records do |t|
      t.integer   :hour_id,     null: false
      t.integer   :minute_id,   null: false
      t.integer   :second_id,   null: false
      t.timestamps
    end
  end
end
