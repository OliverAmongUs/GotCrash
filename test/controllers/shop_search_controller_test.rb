require 'test_helper'

class ShopSearchControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = users(:one) #test Fixer
    sign_in
  end

  def sign_in #Use this if you need a user to be logged in
    post login_path, params: { session: { email:    @owner.email,
                                          password: 'password' } }
  end
  test "should get search" do
    get shopsearch_path
    assert_response :success
  end

end
