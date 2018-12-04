require 'test_helper'

class ReportJoinAutoControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get report_join_auto_new_url
    assert_response :success
  end

end
