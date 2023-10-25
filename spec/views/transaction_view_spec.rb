require 'rails_helper'

RSpec.describe 'transactions/index.html.erb', type: :view do
  it 'displays a list of transactions and a link to create a new transaction' do
    category = Category.create(name: 'Category1', icon: 'Icon1',
                               author: User.create(name: 'User', email: 'user@user.com', password: 'password'))
    transactions = [
      Transaction.create(name: 'Transaction 1', amount: 50, category_id: category),
      Transaction.create(name: 'Transaction 2', amount: 30, category_id: category)
    ]

    assign(:category, category)
    assign(:transactions, transactions)

    render

    expect(rendered).to have_content('Transactions')


    transactions.each do |transaction|
      expect(rendered).to have_selector('.transaction-name', text: transaction.name)
      expect(rendered).to have_selector('.transaction-amount', text: "$#{transaction.amount}")
    end

    expect(rendered).to have_link('Add a New Transaction', href: new_category_transaction_path(category))
  end
end

RSpec.describe 'transactions/new.html.erb', type: :view do
  before(:each) do
    category = Category.create(name: 'Category1', icon: 'Icon1',
                               author: User.create(name: 'User', email: 'user@user.com', password: 'password'))
    transaction = Transaction.new
    assign(:category, category)
    assign(:transaction, transaction)
  end

  it 'displays the form for creating a new transaction' do
    render

    expect(rendered).to have_selector('div.transaction-header') do
      have_selector 'h1', text: 'Add a New Transaction'
      have_selector 'form[action=?][method=?]', categories_path, 'post' do
      end
    end
  end
end
