class Admins::Projects::NotificationsController < Admins::BaseController
  def create
    @project = current_admin.projects.wait_comments.find(params[:project_id])
    @notification = @project.notifications.build(notification_params.merge(admin_id: current_admin.id))

    if @notification.save
      @project.not_accept!

      redirect_to admins_projects_path, notice: t('notice')
    else
      redirect_to admins_project_path(@project), alert: t('.alert')
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:message)
  end
end
