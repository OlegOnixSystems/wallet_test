class User < ApplicationRecord
  belongs_to :team
  has_one :wallet, as: :owner

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  after_create :create_wallet
end
