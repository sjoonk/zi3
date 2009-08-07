module CommentsHelper

  def display_comments(comments, parent_id, commentable_id)
    ret = "\n<ul class=\"comments\" id=\"comment_#{commentable_id}_#{parent_id || 0 }\">"
    comments.each do |comment|
      if comment.parent_id == parent_id
        ret += "\n\t<li>"
        ret += yield comment
        ret += display_comments(comments, comment.id, commentable_id) { |node| yield node }
        ret += "\t</li>\n"
      end  
    end
    ret += "</ul>\n"
  end

end
