require 'test_helper'

class WebsiteLinksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get website_links_create_url
    assert_response :success
  end

  test "should get destroy" do
    get website_links_destroy_url
    assert_response :success
  end

end
