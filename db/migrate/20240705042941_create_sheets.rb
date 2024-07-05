class CreateSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :sheets do |t|
      t.integer :column, null: false, limit: 1
      t.string :row, null: false, limit: 1

      t.timestamps null: false
    end
  end
end
