require "test_helper"

class ProjectProposalsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get project_proposals_create_url
    assert_response :success
  end

  test "should get show" do
    get project_proposals_show_url
    assert_response :success
  end

  test "should get update" do
    get project_proposals_update_url
    assert_response :success
  end

  test "should get destroy" do
    get project_proposals_destroy_url
    assert_response :success
  end
end
