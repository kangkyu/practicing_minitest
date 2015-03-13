require "test_helper"

class PostsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    
    assert_not_nil assigns(:posts)
  end

  def setup
    @post = posts(:one)
  end

  test "should get show" do
    get :show, id: @post.id
    assert_response :success
  end
end
