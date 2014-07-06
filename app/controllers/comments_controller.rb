class CommentsController < ApplicationController
  before_action :find_topic
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  has_scope :after, only: :index
  has_scope :before, only: :index
  has_scope :limit, default: 50, only: :index
  # GET /comments
  # GET /comments.json
  def index
    @comments = apply_scopes(scope)
    respond_with @comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    respond_with @comment
  end

  # GET /comments/new
  def new
    @comment = scope.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = scope.new(comment_params)
    @comment.save
    respond_with @comment, location: [@group, @topic, @comment]
    # respond_to do |format|
    #   if @comment.save
    #     format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @comment }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.update(comment_params)
    respond_with @comment, location: [@group, @topic, @comment]
    # respond_to do |format|
    #   if @comment.update(comment_params)
    #     format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_with @comment
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = scope.find(params[:id])
    end

    def find_topic
      @group = Group.find params[:group_id]
      @topic = @group.topics.find params[:topic_id] if params[:topic_id]
    end

    def scope
      (@topic || @group).comments
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
