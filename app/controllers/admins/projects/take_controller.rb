class Admins::Projects::TakeController < Admins::BaseController
  def create
    @project = Project.without_admin.find(params[:project_id])

    @project.update(admin_id: current_admin.id)

    redirect_to admins_project_path(@project)
  end
end
