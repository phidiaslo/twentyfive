class CreateCashouts < ActiveRecord::Migration
  def change
    create_table :cashouts do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :cashouts, :users
  end
end
