require 'rails_helper'

RSpec.describe UserWallet, type: :model do
  it 'inherits from Wallet' do
    expect(described_class).to be < Wallet
  end
end
