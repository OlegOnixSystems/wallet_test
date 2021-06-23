FactoryBot.define do
  factory :wallet do
    type { %w[UserWallet TeamWallet StockWallet].sample   }
    name { Faker::Alphanumeric.alphanumeric(10) }
  end
end
