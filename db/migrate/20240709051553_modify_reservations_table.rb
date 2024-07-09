class ModifyReservationsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :email, :string
    remove_column :reservations, :name, :string
    add_reference :reservations, :user, null: false, foreign_key: true
  end
end
