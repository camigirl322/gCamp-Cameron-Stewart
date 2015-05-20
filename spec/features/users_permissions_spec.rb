require 'rails_helper'

describe "User Permissions" do
  before :each, 'Create User and Log in' do
    @user = User.create(
      first_name: "Cameron",
      last_name: "Stewart",
      email: "cam@123.com",
      password: "123",
      admin: false
    )
    @other_user = User.create(
      first_name: "Cami",
      last_name: "Stewt",
      email: "cam@1234.com",
      password: "1234",
      admin: false
    )

    @project = Project.create(name: "Cool Project")
    @new_project = Project.create(name: "Awesome Project")


    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content "#{@user.first_name} #{@user.last_name}"
  end

  it "Users see only their email address on users index" do
    visit("/users")
    within("table") do
      expect(page).to have_content "#{@user.full_name} #{@user.email}"
      expect(page).not_to have_content "#{@other_user.full_name} #{@other_user.email}"
    end
  end

  it "Users see their email address and those of members on projects who they are also members of on users index" do
    @user_membership = Membership.create(
      project_id: @project.id,
      user_id: @user.id,
      role: "owner"
    )
    @other_user_membership = Membership.create(
      project_id: @project.id,
      user_id: @other_user.id,
      role: "member"
    )
    visit("/users")
    within("table") do
      expect(page).to have_content "#{@user.full_name} #{@user.email}"
      expect(page).to have_content "#{@other_user.full_name} #{@other_user.email}"
    end
  end

  it "User can only edit themselves" do
    visit("/users/#{@other_user.id}/edit")
    expect(page).to have_content "Whoa there!"
  end

  it "User cannot access project they are not a member of" do
    visit("/projects/#{@new_project.id}")
    expect(page).to have_content "You do not have access to that project"
  end

  it "If a user deletes themself, they get redirected to sign-in path" do
    visit("/users/#{@user.id}/edit")
    click_link "Delete User"
    expect(page).to have_content "Sign into TaskIt"
  end
end
