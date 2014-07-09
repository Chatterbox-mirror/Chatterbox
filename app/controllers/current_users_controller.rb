class CurrentUsersController < ApplicationController
  before_action :authenticate_member!

  def show
    respond_with current_user
  end
end
