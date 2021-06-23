FactoryBot.define do
  factory :transaction do
    amount { rand(1..10) * 100 * [1, -1].sample   }
    wallet
    interact_wallet { build(:wallet) }
  end
end
