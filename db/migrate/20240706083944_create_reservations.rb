class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :schedule, null: false, index: true
      t.references :sheet, null: false, index: true
      t.date :date, null: false
      t.string :email, null: false, limit: 255, comment: '予約者メールアドレス'
      t.string :name, null: false, limit: 50, comment: '予約者名'

      t.timestamps null: false
    end

    add_index :reservations, [:schedule_id, :sheet_id], unique: true
  end
end
