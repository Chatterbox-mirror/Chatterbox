class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = current_user.notifications
		@groups = Group.all
  end

	def category
    @notifications = current_user.notifications
    @category = Category.find_by_name params[:category_name]
		@groups = @category.groups
    render :action => :index
	end
end
