class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :origin
      t.string :destination
      t.date :initial_date
      t.date :final_date

      t.timestamps
    end
  end
end
