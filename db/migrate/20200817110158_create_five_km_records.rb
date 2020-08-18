class CreateFiveKmRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :five_km_records do |t|
      t.integer   :hour_id
      t.integer   :minute_id
      t.integer   :second_id
      t.timestamps
    end
  end
end
