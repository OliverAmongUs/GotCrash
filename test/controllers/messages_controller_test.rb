require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do #Make sure to define any variables you need for testing here
    @message = messages(:one) #These variables are defined in test/fixtures. You will have to add/edit them
    @bid = bids(:one) #one of the two bid fixtures, fixtures are added from bottom to top, so Bid.last will be bids(:one)
    @fixer = users(:two) #test Fixer
    sign_in
  end
  #Note: you will have to go through the controllers to make sure everything works with the test data
  #Byebug calls in your controllers will work during the test if you want to use that

  def sign_in #Use this if you need a user to be logged in
    post login_path, params: { session: { email:    @fixer.email,
                                          password: 'password' } }
  end
  
  test "should get index" do
    get messages_url(bid_id: @bid.id) #make sure that you pass in any parameters
    assert_response :success
  end

  test "should get new" do
    get messages_url(bid_id: @bid.id)
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post messages_url, params: { bid_id: @bid.id, message: { body: @message.body, user_id: @fixer.id } }
    end
  end
end
