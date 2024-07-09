class AddScreenIdToSheets < ActiveRecord::Migration[6.1]
  def change
    add_reference :sheets, :screen, null: false, foreign_key: true
  end
end
