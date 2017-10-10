class ProjectsController < ApplicationController
  PER_PAGE_SIZE = 12

  def index
    @projects = Project.accepted.page(params[:page]).per(PER_PAGE_SIZE)
  end

  def show
    @project = Project.accepted.find(params[:id])
  end
end
