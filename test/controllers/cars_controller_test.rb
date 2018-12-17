require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:one)
    @anothercar = cars(:two)
    @fixer = users(:two)
    sign_in
  end

  def sign_in #Use this if you need a user to be logged in
    post login_path, params: { session: { email:    @fixer.email,
                                          password: 'password' } }
  end


  test "should get edit" do
    get edit_car_path(id: @car.id)
    assert_response :success
  end

  test "should get index" do
    get cars_path
    assert_response :success
  end

  test "should get new" do
    get new_car_path
    assert_response :success
  end

  test "should get show" do
    get car_path(id: @car.id)
    assert_response :success
  end

end
