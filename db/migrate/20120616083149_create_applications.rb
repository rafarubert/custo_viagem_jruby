class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|

      t.timestamps
    end
  end
end
