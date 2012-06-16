class CreateTripItems < ActiveRecord::Migration
  def change
    create_table :trip_items do |t|
      t.references :trip
      t.string :key
      t.string :value
      t.boolean :accepted

      t.timestamps
    end
    add_index :trip_items, :trip_id
  end
end
