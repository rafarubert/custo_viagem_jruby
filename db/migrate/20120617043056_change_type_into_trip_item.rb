class ChangeTypeIntoTripItem < ActiveRecord::Migration
  def change
    remove_column :trip_items, :type
    add_column :trip_items, :service , :string
  end
end
