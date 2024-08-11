class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :balance, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
