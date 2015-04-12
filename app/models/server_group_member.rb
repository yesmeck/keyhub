class ServerGroupMember < ActiveRecord::Base
  belongs_to :server_group, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
