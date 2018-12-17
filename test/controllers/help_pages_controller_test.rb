require 'test_helper'

class HelpPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get ownerhelp" do
    get help_pages_ownerhelp_url
    assert_response :success
  end

  test "should get fixerhelp" do
    get help_pages_fixerhelp_url
    assert_response :success
  end

end
