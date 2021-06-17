class SchemaSetUp < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.timestamps
      t.string :type, null: false
      t.string :name, null: false
      t.index [:type, :name], unique: true
    end
    create_table :transactions do |t|
      t.timestamp :created_at, null: false
      t.decimal :amount, null: false, :precision => 9, :scale => 2
      t.references :wallet, null: false
      t.references :interact_wallet, null: false
    end
  end
end
