class CreateFiveKmRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :five_km_records do |t|
      t.integer   :hour
      t.integer   :minute
      t.integer   :second
      t.timestamps
    end
  end
end
