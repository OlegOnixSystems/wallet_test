class SchemaSetUp < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :name, null: false
      t.references :team, null: false
    end
    create_table :teams do |t|
      t.timestamps
      t.string :name, null: false
    end
    create_table :stocks do |t|
      t.timestamps
      t.string :name, null: false
    end
    create_table :wallets do |t|
      t.timestamps
      t.references :owner, polymorphic: true
    end
    create_table :transactions do |t|
      t.timestamps
      t.string :name, null: false
    end
  end
end
