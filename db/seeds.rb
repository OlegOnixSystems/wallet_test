# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

[Wallet, Stock, Team, User].each do |model|
  ActiveRecord::Base.connection.truncate(model.table_name)
end

{
  'Lannisters' => ['Tyrion Lannister', 'Cersei Lannister', 'Jaime Lannister'],
  'Starks' => ['Jon Snow', 'Sansa Stark', 'Arya Stark'],
  'Baratheons' => ['Joffrey Baratheon', 'Stannis Baratheon', 'Tommen Baratheon']
}.each do |team_name, users|
  team = Team.create!(name: team_name)
  users.each { |user_name| team.users.create!(name: user_name)  }
end

['Casterly Rock', 'Winterfell', 'Red Keep'].each { |name| Stock.create!(name: name) }
