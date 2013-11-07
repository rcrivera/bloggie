class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
    @post_id = params[:post_id]
    @post = Post.find(@post_id)
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)
    @post_id = @tag.post_id
    tags_list = @tag.title.split(",")
    #Rails.logger.info "XXXXXXXXXXXXXXXXXXXXX  Tag = #{tags_list}"

    i = 1
    tags_list.each do |tag|
      @tag = Tag.new(:post_id => @post_id, :title => tag)
      @tag.save
      i+=1
    end

    respond_to do |format|

      if i!= tags_list.size
        format.html { redirect_to :controller => 'posts', :action => 'show', :id => @post_id, notice: 'Tag was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tag }
      else
        format.html { render action: 'new' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @post_id = @tag.post_id
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to :controller => 'posts', :action => 'show', :id => @post_id}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:title, :post_id)
    end
end
