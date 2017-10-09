class Admin < ActiveRecord::Base
  devise :database_authenticatable, :trackable

  has_many :projects
end
