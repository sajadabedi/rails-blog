class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog_post, except: %i[index new create]

  def index
    @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
    @pagy, @blog_posts = pagy(@blog_posts)
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(
      :title,
      :content,
      :published_at,
      :cover_image
    )
  end

  def set_blog_post
    if user_signed_in?
      @blog_post = BlogPost.find(params[:id]) #find any post
    else
      @blog_post = BlogPost.published.find(params[:id]) # only published post
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
