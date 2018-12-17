require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do #Make sure to define any variables you need for testing here
    @fixer = users(:two) #test Fixer
    @review = reviews(:one)
    @report = reports(:one)
    sign_in
  end

  def sign_in #Use this if you need a user to be logged in
    post login_path, params: { session: { email:    @fixer.email,
                                          password: 'password' } }
  end

  test "should get new" do
    get reviews_new_url(id: @review.id, params: { fixerID: @fixer.id, reportID: @report.id})
    assert_response :success
  end

  test "should get show" do
    get reviews_show_url(id: @review.id)
    assert_response :success
  end

  test "should get index" do
    get reviews_index_url
    assert_response :success
  end

end
