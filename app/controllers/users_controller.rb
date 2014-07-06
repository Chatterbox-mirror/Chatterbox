class UsersController < ApplicationController
  before_action :set_user, only: :show
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
  end

  def show
    respond_with @user
  end

  private

    def set_user
      @user = User.find params[:id]
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
