require 'test_helper'

class BidsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bid = bids(:one)
    @fixer = fixers(:one)
  end

  test "should get index" do
    get fixer_bids_path(@fixer)
    assert_response :success
  end

  test "should get new" do
    get new_fixer_bid_path
    assert_response :success
  end

  test "should create bid" do
    assert_difference('Bid.count') do
      post fixer_bids_path, params: { bid: {  } }
    end

    assert_redirected_to fixer_bid_path(Bid.last)
  end

  test "should show bid" do
    get fixer_bid_path(@bid)
    assert_response :success
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
