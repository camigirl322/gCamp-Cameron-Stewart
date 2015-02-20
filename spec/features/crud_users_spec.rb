require 'rails_helper'


describe 'User can CRUD users' do
  before :each do
    visit root_path
    click_link 'Users'
  end

  it 'User can see users page' do
    expect(page).to have_content 'Users'
  end

  it 'User can create user' do
    click_link 'New User'
    expect(page).to have_content 'New User'
    fill_in 'First name', with: 'User FName'
    fill_in 'Last name', with: 'User LName'
    fill_in 'Email', with: 'cameron.webster@gmail.com'
    click_button 'Create User'
    expect(page).to have_content 'Users'
  end

  it 'User can view user show page' do
    @user = User.create(first_name: 'Cameron', last_name: 'Webster', email: 'cameron@mail.com')
    visit("/users/#{@user.id}")
    expect(page).to have_content @user.first_name
  end


end
