require 'rails_helper'

RSpec.describe 'Transactions', type: :feature do
  it 'displays a list of transactions and a link to create a new transaction' do
    user = User.create(name: 'User', email: 'user@user.com', password: 'password')
    category = Category.create(name: 'Category1', icon: 'Icon1', author: user)
    Transaction.create(name: 'Transaction 1', amount: 50, category_id: 1)
    user.confirm

    visit new_user_session_path

    fill_in 'Email', with: 'user@user.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit category_transactions_path(category)

    expect(page).to have_content('Transactions')
    expect(page).to have_link('Add a New Transaction', href: new_category_transaction_path(category))
  end

  it 'displays the form for creating a new transaction' do
    user = User.create(name: 'User', email: 'user@user.com', password: 'password')
    category = Category.create(name: 'Category1', icon: 'Icon1', author: user)
    user.confirm

    visit new_user_session_path

    fill_in 'Email', with: 'user@user.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit new_category_transaction_path(category)

    expect(page).to have_selector('.transaction-header') do
      have_selector 'h1', text: 'Add a New Transaction'
    end

    expect(page).to have_selector("form[action='#{category_transactions_path(category)}'][method='post']") do
  have_button 'Save'
    end
  end
end
