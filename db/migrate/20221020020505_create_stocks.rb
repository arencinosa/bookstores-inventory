class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.belongs_to :bookstore, :index => true
      t.belongs_to :book, :index => true
      t.integer :stock_level, :default => 0

      t.timestamps
    end

    add_foreign_key :stocks, :bookstores
    add_foreign_key :stocks, :books
  end
end
