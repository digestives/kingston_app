class PostsController < ApplicationController

  before_filter :authenticate, :only => [:index, :edit, :update, :destroy, :new]
  before_filter :admin_user,   :only => [:new, :edit, :update, :destroy, :create]

  def index
    @title = "News"
    @posts = Post.paginate(:page => params[:page], :per_page => 5)
    @post = Post.new if signed_in_and_admin?
  end

  def new
		@title = "New Post"
		@post = Post.new
		@post.published = true
  end

  def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			flash[:success] = "Post created!"
		  redirect_to posts_path
    else
		  @title = "New Post"
		  render 'new'
		end
  end

  def edit
  	@title = "Edit Post"
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	if @post.update_attributes(params[:post])
  		flash[:notice] = "Post #{@post.id} Updated"
  		redirect_to posts_path
  	else
  		@title = "Edit Post"
  		render 'edit'
  	end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def admin_user
      redirect_to(root_path) unless signed_in_and_admin?
    end


end

