require 'rails_helper'


describe 'User can CRUD users' do
  before :each, 'user logs in' do
    @user = User.create(first_name: "Cameron", last_name: "Stew", email: "cam@awesome.com", password: "awesome", password_confirmation: "awesome")
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content "#{@user.first_name} #{@user.last_name}"
    within('.col-md-4') do
      click_link 'Users'
    end
  end

  it 'User can see users index page' do
    expect(page).to have_content 'Users'
  end

  it 'User can create user' do
    click_link 'New User'
    expect(page).to have_content 'New User'
    fill_in 'First name', with: 'User FName'
    fill_in 'Last name', with: 'User LName'
    fill_in 'Email', with: 'cameron.webster@test.com'
    fill_in 'Password', with: 'pass'
    fill_in 'Password confirmation', with: 'pass'
    click_button 'Create User'
    expect(page).to have_content 'Users'
  end

  it 'User can view user show page' do
    @user = User.create(first_name: 'Cameron', last_name: 'Webster', email: 'cameron@mail.com', password: '098', password_confirmation: '098')
    visit("/users/#{@user.id}")
    expect(page).to have_content @user.first_name
  end

  it 'User can edit existing user' do
    @user = User.create(first_name: 'Cameron1', last_name: 'Webster1', email: 'cameron@mail.com', password: '098', password_confirmation: '098')
    visit("/users/#{@user.id}/edit")
    expect(page).to have_content 'Edit User'
    fill_in 'First name', with: 'CAM'
    fill_in 'Last name', with: 'STEW'
    fill_in 'Email', with: 'cameron.webster@gmail.com123'
    click_button 'Update User'
    expect(page).to have_content 'User was successfully updated.'

  end

  it "user can't edit email to be another user's email" do
    @user = User.create(first_name: 'Cameron1', last_name: 'Webster2', email: 'cameron123@mail.com', password: '098', password_confirmation: '098')
    @other_user = User.create(first_name: 'Cameron2', last_name: 'Webster2', email: 'cameron567@mail.com', password: '098', password_confirmation: '098')
    visit("/users/#{@user.id}/edit")
    expect(page).to have_content 'Edit User'
    fill_in 'Email', with: 'cameron567@mail.com'
    click_button 'Update User'
    expect(page).to have_content 'Email has already been taken'
  end

  it 'User can delete existing user' do
    @user = User.create(first_name: 'Cameron', last_name: 'Webster', email: 'cameron@mail.com', password: '098', password_confirmation: '098')
    visit("/users/#{@user.id}/edit")
    click_link 'Delete User'
    expect(page).to have_content 'User was successfully deleted'
  end
end
