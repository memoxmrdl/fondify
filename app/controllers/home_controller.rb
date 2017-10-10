class HomeController < ApplicationController
  def index
    @current_projects = Project.accepted.order(created_at: :desc).limit(4)
  end
end
