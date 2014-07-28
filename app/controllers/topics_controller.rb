class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy, :new, :close]
  before_action :find_group
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :close]
  layout 'groups'
  has_scope :by_status, only: :index, default: 'open'
  # GET /topics
  # GET /topics.json
  def index
    @topics = apply_scopes(scope)
    @topic = Topic.where(params[:id]).first if params[:id].present?
    respond_with @topics
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    respond_with @topic
  end

  # GET /topics/new
  def new
    @topic = scope.new
  end

  # GET /topics/1/edit
  def edit
  end

  def close
    if current_user == @topic.owner
      @topic.close!
      respond_with @topic, location: [@group, @topic]
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = scope.new(topic_params)
    @topic.owner_id = current_user.id
    @topic.save
    respond_with @topic, location: [@group, @topic]
    # respond_with @topic
    # respond_to do |format|
    #   if @topic.save
    #     format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @topic }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @topic.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    @topic.update(topic_params)
    respond_with @topic, location: [@group, @topic]
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_with @topic, location: [@group, @topic]
    # respond_to do |format|
    #   format.html { redirect_to topics_url }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = scope.find(params[:id])
    end

    def find_group
      @group = Group.find params[:group_id]
    end

    def scope
      @group.topics
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :description, :group_id)
    end
end
