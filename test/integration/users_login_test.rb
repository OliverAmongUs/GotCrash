require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
      @user = users(:one)
    end


  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to profiles_url
    get logout_path
    assert_not is_logged_in?
  end
end
