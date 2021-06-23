require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it 'inherits from ApplicationRecord' do
    expect(described_class).to be < ApplicationRecord
  end

  describe 'Columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
    it { is_expected.to have_db_column(:type) }
    it { is_expected.to have_db_column(:name) }

    it { is_expected.to have_db_index(%i[type name]).unique }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:transactions) }
  end

  describe 'Validations' do
    subject { build(:wallet) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
  end

  describe '#balance' do
    subject { wallet.balance }
    let(:wallet) { create(:wallet) }
    let!(:transactions) { create_list(:transaction, 5, wallet: wallet) }
    it { is_expected.to eq(transactions.map(&:amount).sum) }
  end
end
