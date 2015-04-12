class ServerGroup < ActiveRecord::Base
  belongs_to :project

  has_many :server_group_members
end
