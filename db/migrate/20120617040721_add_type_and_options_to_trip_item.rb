class AddTypeAndOptionsToTripItem < ActiveRecord::Migration
  def change
    add_column :trip_items, :options, :string
    add_column :trip_items, :type, :string
  end
end