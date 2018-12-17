require 'test_helper'

class BidsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bid = bids(:one)
    @fixer = users(:two)
    sign_in
  end

  def sign_in
    post login_path, params: { session: { email:    @fixer.email,
                                          password: 'password' } }
  end

  test "should get index" do
    get fixer_bids_path(@fixer) #this needs to be bids_url or something, cuz I was messing with it. Look at the cars test for example
    assert_response :success
  end

  test "should get new" do
    get new_fixer_bid_path(@fixer, params:{report_id: @bid.report.id})
    assert_response :success
  end

  test "should show bid" do
    get fixer_bid_path(@bid)
    assert_response :success
  end

  test "should create bid" do
    assert_difference('Bid.count') do
      post fixer_bids_path(@fixer, params: { bid: {description: "insert bid test", cost: 100,report_id: 1} })
    end

    assert_redirected_to fixer_bid_path(Bid.last)
  end

  test "should get edit" do
    get edit_fixer_bid_path(@bid)
    assert_response :success
  end

  test "should update bid" do
    patch fixer_bid_path(@bid), params: { bid: {  } }
    assert_redirected_to fixer_bid_path(@bid)
  end

  test "should destroy bid" do
    assert_difference('Bid.count', -1) do
      delete fixer_bid_path(@bid)
    end

    assert_redirected_to fixer_bids_path
  end
end
