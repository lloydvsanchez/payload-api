class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.integer :status, null: false, default: 0
      t.references :guest, null: false, foreign_key: true
      t.string :currency, null: false, default: 'USD'
      t.float :payout_price, precision: 8, scale: 2
      t.float :security_price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :reservations, :code, unique: true
  end
end
