class PostObserver < ActiveRecord::Observer

  def after_save(post)
    PostMailer.deliver_notify(post) if post.noti? && !post.do_not_apply_callback
  end
end
