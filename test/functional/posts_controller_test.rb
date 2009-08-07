require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @curr_user = :quentin
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  def test_should_redirect_without_login
    get :new
    assert_response :redirect
  end

  def test_should_create_post
    login_as @curr_user
    assert_difference('Post.count') do
      post :create, :post => { :title => 'just test' }
    end
    assert_redirected_to posts_path
  end

  def test_should_show_post
    get :show, :id => posts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as @curr_user
    get :edit, :id => posts(:one).id
    assert_response :success
  end

  def test_should_update_post
    login_as @curr_user
    put :update, :id => posts(:one).id, :post => { }
    assert_redirected_to post_path(assigns(:post))
  end

  def test_should_destroy_post
    login_as @curr_user
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).id
    end
    assert_redirected_to posts_path
  end
end
