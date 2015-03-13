require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest

  test "list posts" do
    get "/"
    assert_response :success
    assert_template "index"
  end
end
