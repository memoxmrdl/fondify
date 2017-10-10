class Admins::ProjectsController < Admins::BaseController
  before_action :find_project, except: [:index]

  def index
    @projects = Project.wait_comments
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params.merge(admin_changes: true))
      redirect_to admins_projects_path, notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @project.destroy

    redirect_to admins_projects_path, notice: t('.notice')
  end

  private

  def project_params
    params.require(:project).permit(:title, :short_description, :description, :image)
  end

  def find_project
    @project = Project.wait_comments.find(params[:id])
  end
end
