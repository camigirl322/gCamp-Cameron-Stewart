class CommentsController < ApplicationController
  before_action :set_project, :set_task
  before_filter :authorize

  def index
    @comments = Comment.all
    @comment = Comment.new
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    @comment.user_id = current_user.id
    @comment.task_id = params[:task_id]
    if @comment.save
      redirect_to project_task_path(@project, @task), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:user_id, :task_id, :description)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  # def set_comment
  #   @comment = Comment.find(params[:id])
  # end

end
