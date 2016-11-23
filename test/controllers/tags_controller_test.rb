require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tags_create_url
    assert_response :success
  end

  test "should get find" do
    get tags_find_url
    assert_response :success
  end

  test "should get show" do
    get tags_show_url
    assert_response :success
  end

end
