class Wallet < ApplicationRecord
  has_many :transactions

  validates :name, presence: true, uniqueness: { scope: :type }, length: { maximum: 255 }

  def balance
    transactions.sum(:amount)
  end
end
