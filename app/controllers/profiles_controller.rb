class ProfilesController < ApplicationController
  def edit
    @profile = current_user

  end

  def show
    @cars = current_user.cars
    if logged_in?
      @profile ||= current_user
      @user2 = @profile
    else
      redirect_to login_path
    end
  end

  def update
    puts "123"
    # current_user.update()
  end
end
