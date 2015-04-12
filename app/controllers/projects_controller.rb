class ProjectsController < ApplicationController
  before_action :require_login
  before_action :set_project, only: [:show, :destroy, :invite_user, :add_user]

  def index
    @projects = current_user.projects
  end

  def show
    @users = @project.users
  end

  def create
    @project = current_user.projects.create!(project_params)
  end

  def destroy
    @project.destroy!

    redirect_via_turbolinks_to projects_path
  end

  def invite_user
  end

  def add_user
    @user = User.find_by!(email: params[:email])
    @project.users << @user

    redirect_via_turbolinks_to project_path
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
