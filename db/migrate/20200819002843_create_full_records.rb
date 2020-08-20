class CreateFullRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :full_records do |t|
      t.integer   :hour_id
      t.integer   :minute_id
      t.integer   :second_id
      t.references :user,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
