class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.references :movie, null: false
      t.integer :reservation_count, null: false
      t.date :date, null: false

      t.timestamps null: false
    end
  end
end
