class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :quit]
  has_scope :page, only: :index, allow_blank: true
  layout 'groups', except: [:index]
  # GET /groups
  # GET /groups.json
  def index
    @groups = apply_scopes(Group.all)
    respond_with @groups, layout: 'application'
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
		@group.members << current_user if @group.members.find_by_id(current_user.id).nil?
    respond_with @group do |format|
      format.html { redirect_to [@group, @group.topics.first] if @group.topics.count > 0 }
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
    respond_with @group
  end

  # GET /groups/1/edit
  def edit
    respond_with @group
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      respond_with @group, location: @group
    else
      respond_with @group.errors, status: :unprocessable_entity
    end
    # respond_to do |format|
    #   if @group.save
    #     format.html { redirect_to @group, notice: 'Group was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @group }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @group.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @group.update(group_params)
    respond_with @group
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    # respond_to do |format|
    #   format.html { redirect_to groups_url }
    #   format.json { head :no_content }
    # end
    respond_with @group
  end

  def join
    @group.members << current_user
    redirect_to @group
  end

  def quit
    @group.members.delete(current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :icon, :category_id)
    end
end
