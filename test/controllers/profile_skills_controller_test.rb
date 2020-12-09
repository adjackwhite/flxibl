require 'test_helper'

class ProfileSkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get profile_skills_create_url
    assert_response :success
  end

  test "should get destroy" do
    get profile_skills_destroy_url
    assert_response :success
  end

end
