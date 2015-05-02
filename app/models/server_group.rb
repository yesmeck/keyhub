require "base64"

class ServerGroup < ActiveRecord::Base
  belongs_to :project

  has_many :server_group_members

  class << self
    def find_by_api_key!(api_key)
      find(Rails.application.message_verifier('server_group_api_key').verify(api_key))
    end
  end

  def api_key
    Rails.application.message_verifier('server_group_api_key').generate(id)
  end
end
