class AboutController < ApplicationController
  def index
    @projects = Project.all.count
    @tasks = Task.all.count
    @memberships = Membership.all.count
    @users = User.all.count
    @comments = Comment.all.count
  end
end
