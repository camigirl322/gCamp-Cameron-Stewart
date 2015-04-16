class MembershipsController < ApplicationController
  before_action :set_project, :owner

  def index
    @memberships = Membership.all
    @membership = Membership.new
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new
    @membership.user_id = params[:membership][:user_id]
    @membership.project_id = @project.id


    respond_to do |format|
      if @membership.save
        format.html { redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was successfully added" }
        format.json { render :index, status: :created, location: @project }
      else
        format.html { render :index }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @membership = Membership.find(params[:id])
      if @membership.update(membership_params)
        redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
      end
  end

  def destroy
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

  def owner
    unless @project.users.include? current_user
        redirect_to projects_path, alert: "You do not have access to that project"
    end
  end
end
