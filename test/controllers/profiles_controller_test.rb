require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fixer = users(:two) #test Fixer
    sign_in
  end

  def sign_in
    post login_path, params: { session: { email:    @fixer.email,
                                          password: 'password' } }
  end
  test "should get edit" do
    get profiles_edit_url
    assert_response :success
  end

  test "should get show" do
    get profiles_path
    assert_response :success
  end

end
