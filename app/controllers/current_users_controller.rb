class CurrentUsersController < ApplicationController
  before_action :authenticate_user!

  def show
    respond_with current_user
  end
end
