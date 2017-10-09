class Users::ProjectsController < Users::BaseController
  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to users_projects_path, notice: t('.notice')
    else
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.update(project_params)
      redirect_to users_projects_path, notice: t('.notice')
    else
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :short_description, :description)
  end
end
