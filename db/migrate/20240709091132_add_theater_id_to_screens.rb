class AddTheaterIdToScreens < ActiveRecord::Migration[6.1]
  def change
    add_reference :screens, :theater, null: false, foreign_key: true
    add_column :screens, :number, :integer, null: false

    add_index :screens, [:theater_id, :number], unique: true
  end
end
