class PostMailer < ActionMailer::Base

  def notify(post)
    subject     post.title
    from        APP_CONFIG[:admin_email]
    recipients  User.all.map(&:email) 
    sent_on     post.updated_at
    body       :post => post, 
               :post_url => make_post_url(post)
    content_type "text/html"
  end
  
  private

  def make_post_url(post)
    if post.is_reply?
      #board_post_url(post.post.board, post.post, :anchor => "reply-1", :host => APP_CONFIG[:site_url])
      "#{APP_CONFIG[:site_url]}/boards/#{post.post.board.id}/posts/#{post.post.id}#reply-#{post.id}"
    else
      #board_post_url(post.board, post, :host => APP_CONFIG[:site_url])
      "#{APP_CONFIG[:site_url]}/boards/#{post.board.id}/posts/#{post.id}"
    end
  end
end
