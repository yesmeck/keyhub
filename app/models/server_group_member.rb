class ServerGroupMember < ActiveRecord::Base
  belongs_to :server_grou
  belongs_to :user
end
