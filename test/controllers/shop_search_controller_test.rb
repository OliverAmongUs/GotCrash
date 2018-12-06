require 'test_helper'

class ShopSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get shop_search_search_url
    assert_response :success
  end

end
