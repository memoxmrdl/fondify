class ProjectsController < ApplicationController
  def index
    @projects = Project.accepted
  end

  def show
    @project = Project.accepted.find(params[:id])
  end
end
