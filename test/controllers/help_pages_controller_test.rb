require 'test_helper'

class HelpPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = users(:one)
    sign_in
  end

  def sign_in
    post login_path, params: { session: { email:    @owner.email,
                                          password: 'password' } }
  end
  test "should get ownerhelp" do
    get help_pages_ownerhelp_url
    assert_response :success
  end

  test "should get fixerhelp" do
    get help_pages_fixerhelp_url
    assert_response :success
  end

end
