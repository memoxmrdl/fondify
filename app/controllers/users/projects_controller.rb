class Users::ProjectsController < Users::BaseController
  before_action :find_project, except: [:index, :new, :create]

  PER_PAGE_SIZE = 12

  def index
    @projects = current_user.projects.page(params[:page]).per(PER_PAGE_SIZE)
  end

  def show
    @notifications = @project.notifications.without_updated
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
  end

  def update
    if @project.update(project_params)
      redirect_to users_projects_path, notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @project.destroy

    redirect_to users_projects_path, notice: t('.notice')
  end

  private

  def project_params
    params.require(:project).permit(:title, :short_description, :description, :image)
  end

  def find_project
    @project = current_user.projects.find(params[:id])
  end
end
