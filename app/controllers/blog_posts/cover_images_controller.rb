class BlogPosts::CoverImagesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_blog_post
  #delete cover images by id

  def destroy
    @blog_post.cover_image.purge_later
    respond_to do |format|
      format.html { redirect_to edit_blog_post_path(@blog_post) }
      format.turbo_stream do
        render turbo_stream:
                 turbo_stream.remove(dom_id(@blog_post, :cover_image))
      end
    end
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end
end
