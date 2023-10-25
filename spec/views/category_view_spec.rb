require 'rails_helper'

RSpec.describe 'categories/index.html.erb', type: :view do
  it 'displays a list of categories and a link to create a new category' do
    user = User.create(name: 'User', email: 'user@user.com', password: 'password')
    category1 = Category.create(name: 'Category1', icon: 'Icon1', author: user)
    category2 = Category.create(name: 'Category2', icon: 'Icon2', author: user)

    assign(:categories, [category1, category2])
    render
    expect(rendered).to have_content('Categories')
    expect(rendered).to have_selector('.category-link', count: 2)
    expect(rendered).to have_selector('.category-image', count: 2)
    expect(rendered).to have_selector('.category-name', text: 'Category1')
    expect(rendered).to have_selector('.category-name', text: 'Category2')
    expect(rendered).to have_selector('.category-amount', text: '$0')
    expect(rendered).to have_link('Add a New Category', href: new_category_path)
  end
end

RSpec.describe 'categories/new.html.erb', type: :view do
  before(:each) do
    assign(:category, Category.new)
  end

  it 'displays the form for creating a new category' do
    render

    expect(rendered).to have_selector('div.category-header') do
      have_selector 'h1', text: 'Add a New Category'
      have_selector 'form[action=?][method=?]', categories_path, 'post' do
      end
    end
  end
end
