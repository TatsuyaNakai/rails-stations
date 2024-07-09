class AddScreenIdToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_reference :schedules, :screen, null: false, foreign_key: true
  end
end
