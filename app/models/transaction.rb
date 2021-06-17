class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :interact_wallet, class_name: 'Wallet', foreign_key: 'interact_wallet_id'

  scope :income_only, -> { where(arel_table[:amount].gt(0)) }
  scope :outcome_only, -> { where(arel_table[:amount].lt(0)) }

  validates :amount, presence: true, numericality: { other_than: 0 }
end
