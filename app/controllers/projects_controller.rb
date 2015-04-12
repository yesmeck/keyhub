class ProjectsController < ApplicationController
  before_action :require_login

  def index
    @projects = current_user.projects
  end

  def create
    @project = current_user.projects.create!(project_params)
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
