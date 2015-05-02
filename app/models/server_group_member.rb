class ServerGroupMember < ActiveRecord::Base
  belongs_to :server_group, dependent: :destroy
  belongs_to :user, dependent: :destroy

  delegate :username, :ssh_public_key, :name, :preferred_shell, to: :user
end
