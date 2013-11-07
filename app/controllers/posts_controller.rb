class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if ! params[:tag_title].blank?
      #t = Tag.find(params[:tag_id])
      tags = Tag.where(:title => params[:tag_title]).order('id desc')
      @posts = []
      tags.each do |tag|
        parent_blog = tag.post
        @posts.push(parent_blog)
    end
    else
      @posts = Post.order('id desc')
    end
    @tag_search = Tag.select(:title).uniq
    @indv_tags = {}
    @posts.each do |post|
        @indv_tags[post.id] = Tag.where(:post_id => post.id)
        #Rails.logger.info "#{@indv_tags[post.id].size}"
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @tag_search = Tag.select(:title).uniq
    @comments = @post.comments
    @tags = @post.tags

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :body)
    end
end
