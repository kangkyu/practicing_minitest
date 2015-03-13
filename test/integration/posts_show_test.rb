require 'test_helper'

class PostsShowTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  test "show detail of a post" do
    get post_path(@post)
    assert_response :success
    assert_template "show"
  end
end
