class RepliesController < ApplicationController
  before_filter :login_required
  before_filter :find_post

  def create
    @reply = @post.replies.build(params[:reply])
    @reply.user = current_user
    @reply.save
    redirect_to :back
  end

  def destroy
    @reply = current_user.replies.find(params[:id])
    @reply.destroy
    redirect_to :back
  end
  
  private
  
  def find_post
    @post ||= Post.find(params[:post_id])
  end
end
