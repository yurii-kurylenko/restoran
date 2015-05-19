class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :book_start
      t.datetime :book_end
      t.integer :table_number
    end
  end
end