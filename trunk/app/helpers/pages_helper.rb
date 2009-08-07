module PagesHelper
  
  def wikilize(text)
    text.gsub(/\[\[(.*?)\]\]/, '<a href="/pages?title=\1" class="wikiword">\1</a>')
  end
  
  def strip_wiki(text)
    text.gsub(/\[\[(.*?)\]\]/, '\1')
  end
  
  def strip_tags_and_wiki(text)
    strip_wiki(strip_tags(text))
  end
  
  # def intelli_path(page)
  #   if page.type == 'Post'
  #     board_post_path(page.board, page)
  #   else
  #     page_path(page)
  #   end
  # end
  
  def authorized_only_link_to(obj, name, options = {}, html_options = nil)
    if obj.collaborable? || obj.user == current_user
      " | " + link_to(name, options, html_options)
    else
      "" #link_to_function name, '권한이 없습니다.'
    end
  end
end
