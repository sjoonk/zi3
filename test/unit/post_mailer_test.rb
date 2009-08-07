require 'test_helper'

class PostMailerTest < ActionMailer::TestCase
  tests PostMailer
  def test_notify
    @post = Post.new(:title => 'A Test Mail')
    response = PostMailer.create_notify(@post)
    assert_equal "A Test Mail", response.subject
  end

end
