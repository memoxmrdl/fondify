class Admins::Projects::AcceptController < Admins::BaseController
  def create
    @project = current_admin.projects.find(params[:project_id])

    @project.accept!

    redirect_to admins_projects_path, notice: t('notice')
  end
end
