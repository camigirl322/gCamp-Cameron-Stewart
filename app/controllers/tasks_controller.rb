class TasksController < ApplicationController
  before_action :authorize, :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :owner

  def index
    @tasks = @project.tasks.all
  end

  def show
    @comments = Comment.where(:task_id => @task.id)
    @comment = Comment.new
  end

  def new
    @task = @project.tasks.build
  end

  def edit
  end

  def create
    @task = @project.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
          format.html {render :edit }
          format.json {render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def task_params
      params.require(:task).permit(:description, :due_date, :complete, :project_id)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def owner
      unless @project.users.include? current_user
          redirect_to projects_path, alert: "You do not have access to that project"
      end
    end
end
