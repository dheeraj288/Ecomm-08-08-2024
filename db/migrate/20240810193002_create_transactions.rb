class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.references :catalogue_variant, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.string :transaction_type # Either 'credit' or 'debit'
      t.string :status, default: 'pending' # 'pending', 'completed', 'failed'
      
      t.timestamps
    end
  end
end
