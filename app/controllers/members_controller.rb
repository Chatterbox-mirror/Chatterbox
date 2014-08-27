class MembersController < ApplicationController
  before_action :find_group
  respond_to :json

  def index
    respond_with @group.members
  end

  def create
    @user = User.find params[:user][:id]
    if @group.members << @user
      head :created
    end
  end

  def destroy
    @user = User.find params[:id]
    @group.members.delete @user
  end

  private
  def find_group
    @group = Group.find params[:group_id]
  end
end
