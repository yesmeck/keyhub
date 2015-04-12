class ServerGroupsController < ApplicationController
  before_action :set_project
  before_action :set_server_group, only: [:destroy, :set_member, :remove_member]

  def new
    @server_group = ServerGroup.new
  end

  def create
    @server_group = @project.server_groups.create!(server_group_params)

    redirect_via_turbolinks_to project_path(@project)
  end

  def destroy
    @server_group.destroy!

    redirect_via_turbolinks_to project_path(@project)
  end

  def set_member
    server_group_member = @server_group.server_group_members.find_or_initialize_by(user_id: params['user_id'])
    server_group_member.role = params['role']
    server_group_member.save!

    redirect_via_turbolinks_to project_path(@project)
  end

  def remove_member
    member = @server_group.server_group_members.find_by(user_id: params['user_id'])
    member && member.destroy!

    redirect_via_turbolinks_to project_path(@project)
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_server_group
    @server_group = @project.server_groups.find(params[:id])
  end

  def server_group_params
    params.require(:server_group).permit(:name)
  end
end
