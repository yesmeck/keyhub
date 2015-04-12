class User < ActiveRecord::Base
  include Clearance::User

  has_and_belongs_to_many :projects
  has_many :server_group_members

  def role_in(server_group)
    server_group_member = server_group_members.find_by(server_group_id: server_group.id)
    server_group_member.nil? ? 'none' : server_group_member.role
  end
end
