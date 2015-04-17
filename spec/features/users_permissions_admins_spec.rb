require 'rails_helper'


describe "Admin Permissions" do
  before :each, 'Create Admin User and Log in' do
    @admin_user = User.create(
      first_name: "Cameron",
      last_name: "Stewart",
      email: "cam@123.com",
      password: "123",
      admin: true
    )
    @user_two = User.create(
      first_name: "Cami",
      last_name: "Stewt",
      email: "cam@1234.com",
      password: "1234",
      admin: false
    )
    @user_three = User.create(
      first_name: "Cameroni",
      last_name: "Cheese",
      email: "cam@cheese.com",
      password: "cheese",
      admin: false
    )

    @project = Project.create(name: "Cool Project")
    @new_project = Project.create(name: "Awesome Project")

    
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @admin_user.email
    fill_in 'Password', with: @admin_user.password
    click_button 'Sign In'
    expect(page).to have_content "#{@admin_user.full_name}"
  end

  it "Admins can see all email addresses on User index" do
    visit ('/users')
    within("table") do
      expect(page).to have_content "#{@admin_user.full_name} #{@admin_user.email}"
      expect(page).to have_content "#{@user_two.full_name} #{@user_two.email}"
      expect(page).to have_content "#{@user_three.full_name} #{@user_three.email}"
    end
  end

  it "Admins can edit any user" do
    visit("/users/#{@user_two.id}/edit")
    expect(page).to have_content "Edit User"
  end

  it "Admins can delete any user" do
    visit("/users/#{@user_two.id}/edit")
    click_link 'Delete User'
    expect(page).to have_content "User was successfully deleted"
  end

  it "Admins can access any project" do
    visit("/projects/#{@project.id}")
    expect(page).to have_content "#{@project.name}"
  end


end
