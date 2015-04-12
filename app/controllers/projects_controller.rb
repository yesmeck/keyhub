class ProjectsController < ApplicationController
  before_action :require_login
  before_action :set_project, only: [:show, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
  end

  def create
    @project = current_user.projects.create!(project_params)
  end

  def destroy
    @project.destroy!

    redirect_via_turbolinks_to projects_path
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
