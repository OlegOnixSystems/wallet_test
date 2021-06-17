class Wallet < ApplicationRecord
  has_many :transactions

  validates :name, presence: true, uniqueness: { scope: :type }, length: { maximum: 255 }
end
