class Admins::BaseController < ApplicationController
  before_action :authenticate_admin!
end
