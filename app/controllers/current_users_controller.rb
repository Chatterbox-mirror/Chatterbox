class CurrentUsersController < ApplicationController
  before_action :authenticate_user!

  def show
    respond_with current_user
  end

  def groups
    respond_with(@groups = current_user.groups)
  end
end
