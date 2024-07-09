class CreateScreens < ActiveRecord::Migration[6.1]
  def change
    create_table :screens do |t|
      t.timestamps null: false
    end
  end
end
