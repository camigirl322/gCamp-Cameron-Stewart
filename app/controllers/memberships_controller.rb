class MembershipsController < ApplicationController
  before_action :set_project

  def index
    @memberships = Membership.all
    @membership = Membership.new
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = @project.memberships.build(membership_params)
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added"
    else
      render :index
    end
  end



  def update
    @membership = Membership.find(params[:id])
      if @membership.update(membership_params)
        redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
      end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    @membership.project_id = @project.id
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully removed"
  end


  private
  def membership_params
    params.require(:membership).permit(:role, :user_id, :project_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
