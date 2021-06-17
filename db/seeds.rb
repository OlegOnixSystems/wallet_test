# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

[Wallet, Transaction].each do |model|
  ActiveRecord::Base.connection.truncate(model.table_name)
end

users = ['Tyrion Lannister', 'Cersei Lannister', 'Daenerys Targaryen', 'Jon Snow', 'Sansa Stark', 'Arya Stark',
         'Jaime Lannister', 'Jorah Mormont', 'Joffrey Baratheon', 'Stannis Baratheon', 'Tommen Baratheon']
teams = %w[Lannisters Targaryens Starks Baratheons]
stocks = ['Casterly Rock', 'Winterfell', 'Red Keep']

users.each { |name| UserWallet.create!(name: name) }
teams.each { |name| TeamWallet.create!(name: name) }
stocks.each { |name| StockWallet.create!(name: name) }

wallets = users + teams + stocks
20.times do
  target = Wallet.find_by(name: wallets.sample)
  source = Wallet.find_by(name: (wallets - [target]).sample)
  amount = rand(100000..999999).to_f / 100
  Transaction.create!(wallet: target, interact_wallet: source, amount: amount)
  Transaction.create!(wallet: source, interact_wallet: target, amount: -amount)
end
