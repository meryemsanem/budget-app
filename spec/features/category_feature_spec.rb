require 'rails_helper'

RSpec.describe 'Categories', type: :feature do
  it 'displays a list of categories and a link to create a new category' do
    user = User.create(name: 'User', email: 'user@user.com', password: 'password')
    Category.create(name: 'Category1', icon: 'Icon1', author: user)
    Category.create(name: 'Category2', icon: 'Icon2', author: user)

    visit new_user_session_path

    fill_in 'Email', with: 'user@user.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    expect(page).to have_content('Categories')
    expect(page).to have_selector('.category-link', count: 2)
    expect(page).to have_selector('.category-image', count: 2)
    expect(page).to have_selector('.category-name', text: 'Category1')
    expect(page).to have_selector('.category-name', text: 'Category2')
    expect(page).to have_selector('.category-amount', text: '$0')
    expect(page).to have_link('Add a New Category', href: new_category_path)
  end

  it 'displays the form for creating a new category' do
    User.create(name: 'User', email: 'user@user.com', password: 'password')

    visit new_user_session_path

    fill_in 'Email', with: 'user@user.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    visit new_category_path

    expect(page).to have_selector('.category-header') do
      have_selector 'h1', text: 'Add a New Category'
    end

    expect(page).to have_selector('form[action="/categories"][method="post"]') do
      have_button 'Save'
    end
  end
end
