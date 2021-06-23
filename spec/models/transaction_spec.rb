require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'inherits from ApplicationRecord' do
    expect(described_class).to be < ApplicationRecord
  end

  describe 'Columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:amount) }
    it { is_expected.to have_db_column(:wallet_id) }
    it { is_expected.to have_db_column(:interact_wallet_id) }

    it { is_expected.to have_db_index(:wallet_id) }
    it { is_expected.to have_db_index(:interact_wallet_id) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:wallet) }
    it { is_expected.to belong_to(:interact_wallet).class_name('Wallet').with_foreign_key('interact_wallet_id') }
  end

  describe 'Scopes' do
    it '.income_only' do
      expect(described_class.income_only).to(
        eq(described_class.where(described_class.arel_table[:amount].gt(0)))
      )
    end

    it '.outcome_only' do
      expect(described_class.outcome_only).to(
        eq(described_class.where(described_class.arel_table[:amount].lt(0)))
      )
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount) }
  end

  describe '.transfer' do
    let(:source_wallet) { create(:wallet) }
    let(:target_wallet) { create(:wallet) }
    let(:amount) { rand(1..10) * 100 }

    before { Transaction.transfer(source_wallet, target_wallet, amount) }

    it 'creates outcome transaction for source wallet' do
      expect(source_wallet.transactions.count).to eq(1)
      expect(source_wallet.transactions.last).to(
        have_attributes(amount: -amount, interact_wallet_id: target_wallet.id)
      )
    end

    it 'creates income transaction for target wallet' do
      expect(target_wallet.transactions.count).to eq(1)
      expect(target_wallet.transactions.last).to(
        have_attributes(amount: amount, interact_wallet_id: source_wallet.id)
      )
    end
  end

  describe '#incoming?' do
    subject { transaction.incoming? }

    context 'when amount is positive' do
      let(:transaction) { build(:transaction, amount: 100) }
      it { is_expected.to be_truthy }
    end

    context 'when amount is negative' do
      let(:transaction) { build(:transaction, amount: -100) }
      it { is_expected.to be_falsey }
    end
  end

  describe '#outcoming?' do
    subject { transaction.outcoming? }

    context 'when amount is positive' do
      let(:transaction) { build(:transaction, amount: 100) }
      it { is_expected.to be_falsey }
    end

    context 'when amount is negative' do
      let(:transaction) { build(:transaction, amount: -100) }
      it { is_expected.to be_truthy }
    end
  end
end
