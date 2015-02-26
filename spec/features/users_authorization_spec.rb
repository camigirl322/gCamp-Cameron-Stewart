require 'rails_helper'

describe 'user must be logged in to view user page' do
  before :each, 'user log in' do
    @user = User.create(first_name: "Cameron", last_name: "Stewart", email: "cam@awesome.com", password: "awesome", password_confirmation: "awesome")
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content "#{@user.first_name} #{@user.last_name}"
    click_link 'Users'
  end

  it 'logged in users can access user page' do
    visit("/users")
    expect(page).to have_content "Users"
  end
  it 'user cant access users until logged in' do
    click_link 'Sign Out'
    visit("/users")
    expect(page).to have_content "Sign into gCamp"
  end
end
