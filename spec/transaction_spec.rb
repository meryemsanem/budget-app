require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { User.create(name: 'User') }
  let(:transaction) { Transaction.new(user: user, name: 'Transaction Name', amount: 100) }

  it 'is valid with a name, an amount, and an associated user' do
    expect(transaction).to be_valid
  end

  it 'is invalid without a name' do
    transaction.name = nil
    expect(transaction).not_to be_valid
  end

  it 'is invalid when name exceeds 255 characters' do
    transaction.name = 'A' * 256
    expect(transaction).not_to be_valid
  end

  it 'is invalid without an amount' do
    transaction.amount = nil
    expect(transaction).not_to be_valid
  end

  it 'is invalid when amount is not a positive integer' do
    transaction.amount = -1
    expect(transaction).not_to be_valid
  end

  it 'belongs to a user' do
    association = Transaction.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
    expect(association.class_name).to eq('User')
    expect(association.foreign_key).to eq('author_id')
  end

  it 'has many transaction categories' do
    association = Transaction.reflect_on_association(:transaction_categories)
    expect(association.macro).to eq(:has_many)
    expect(association.class_name).to eq('TransactionCategory')
  end

  it 'has many categories through transaction categories' do
    association = Transaction.reflect_on_association(:categories)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:transaction_categories)
  end
end
