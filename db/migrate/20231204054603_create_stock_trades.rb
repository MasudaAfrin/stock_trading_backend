class CreateStockTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_trades do |t|
      t.decimal :price, precision: 10, scale: 2, default: 0.0
      t.integer :quantity, default: 1
      t.integer :trade_status, default: 0
      t.references :business, foreign_key: true, null: false
      t.bigint :buyer_id, null: false
      t.timestamps
    end
  end
end
