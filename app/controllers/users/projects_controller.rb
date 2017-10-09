class Users::ProjectsController < Users::BaseController
  def index
    @projects = current_user.projects
  end
end
