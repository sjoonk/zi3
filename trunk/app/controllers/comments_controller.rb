class CommentsController < ApplicationController
  #before_filter :login_required

  include PolymorphicParent
  parent_resources :note, :photo, :page, :event
  
  # HTML tagging conventions for adding comments (in view)
  # ...
  # <%= link_to_function "댓글", "add_comment('#{note_comments_path(note)}')" if logged_in? %>
  # ...
  #   <div class="comment_area">
  #     <%= display_comments(note.comments, nil, note.id) do |comment| 
  #       render :partial => 'shared/comment', :object => comment 
  #     end %>
  #   </div>
  # ...
  def create
    @parent = parent_object
    @comment = @parent.comments.build(params[:comment])
    @comment.user = current_user if logged_in?
    if @comment.save
      @comment.move_to_child_of(Comment.find(params[:parent_id])) unless params[:parent_id].blank?
      render :update do |page|
        page.insert_html :bottom, @comment.position_id,
                         :partial => 'shared/comment_li', :locals => { :comment => @comment } 
      end
    else
      render :action => 'new'
    end
  end
end
