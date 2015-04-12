class User < ActiveRecord::Base
  include Clearance::User

  has_and_belongs_to_many :projects
end
