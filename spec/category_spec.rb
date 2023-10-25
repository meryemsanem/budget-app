require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:author) { User.create(name: 'Author') }
  let(:category) { Category.new(author:, name: 'Name', icon: 'Icon') }

  it 'is valid with a name, an icon, and an associated author' do
    expect(category).to be_valid
  end

  it 'is invalid without a name' do
    category.name = nil
    expect(category).not_to be_valid
  end

  it 'is invalid without an icon' do
    category.icon = nil
    expect(category).not_to be_valid
  end

  it 'is invalid without an associated author' do
    category.author = nil
    expect(category).not_to be_valid
  end

  it 'belongs to an author (User)' do
    association = Category.reflect_on_association(:author)
    expect(association.macro).to eq(:belongs_to)
    expect(association.class_name).to eq('User')
    expect(association.foreign_key).to eq('author_id')
  end

  it 'has many transactions' do
    association = Category.reflect_on_association(:transactions)
    expect(association.macro).to eq(:has_many)
    expect(association.class_name).to eq('Transaction')
  end

  it 'has many transaction categories' do
    association = Category.reflect_on_association(:transaction_categories)
    expect(association.macro).to eq(:has_many)
    expect(association.class_name).to eq('TransactionCategory')
  end

  it 'has many related transactions through transaction categories' do
    association = Category.reflect_on_association(:related_transactions)
    expect(association.macro).to eq(:has_many)
  end
end
