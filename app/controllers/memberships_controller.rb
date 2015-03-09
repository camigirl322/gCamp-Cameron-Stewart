class MembershipsController < ApplicationController
  before_action :set_project

  def index
    @memberships = Membership.all
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
