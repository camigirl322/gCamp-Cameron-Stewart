require 'rails_helper'


describe 'User can sign up' do
  before :each do
    visit root_path
    click_link 'Sign Up'
  end
  it 'user can sign up with valid creds and will be automatically signed in' do
    fill_in 'First name', with: 'cam'
    fill_in 'Last name', with: 'stew'
    fill_in 'Email', with: 'cameron.webster@gmail.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_button 'Sign up'
    expect(page).to have_content 'You have successfully signed up'
  end

  it "user must enter first name and last name to sign up" do
    fill_in 'Email', with: 'cameron.webster@gmail.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_button 'Sign up'
    expect(page).to have_content "First name can't be blank Last name can't be blank"
  end

  it 'passwords must match to sign up' do
    fill_in 'First name', with: '123'
    fill_in 'Last name', with: '456'
    fill_in 'Email', with: 'cameron.webster@gmail.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '1234'
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end


  it 'email must be unique to sign up' do
    @user = User.create(first_name: "Cam", last_name: "Stewart", email: "cam@awesome.com", password: "awesome", password_confirmation: "awesome")
    fill_in 'First name', with: 'test'
    fill_in 'Last name', with: 'ing'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_button 'Sign up'
    expect(page).to have_content "Email has already been taken"
  end
end

describe "User can log in" do
  before :each do
    @user = User.create(first_name: "Cameron", last_name: "Stew", email: "cam@awesome.com", password: "awesome", password_confirmation: "awesome")
    visit root_path
    click_link 'Sign In'
  end

  it 'user can log in with valid creds' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content "#{@user.first_name} #{@user.last_name}"
  end

  it "user can't login with invalid creds" do
    fill_in 'Email', with: "bogus email"
    fill_in 'Password', with: "bogus pass"
    click_button 'Sign In'
    expect(page).to have_content "Username/password combination is invalid"
  end

  it "user can sign out" do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content "#{@user.first_name} #{@user.last_name}"
    click_link "Sign Out"
    expect(page).to have_content "Sign Up | Sign In"
  end
end
