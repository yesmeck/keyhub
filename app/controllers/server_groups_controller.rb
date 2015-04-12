class ServerGroupsController < ApplicationController
  before_action :set_project

  def new
    @server_group = ServerGroup.new
  end

  def create
    @server_group = @project.server_groups.create!(server_group_params)

    redirect_via_turbolinks_to project_path(@project)
  end

  def destroy
    @server_group = @project.server_groups.find(params[:id])
    @server_group.destroy!

    redirect_via_turbolinks_to project_path(@project)
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def server_group_params
    params.require(:server_group).permit(:name)
  end
end
