class ProfilesController < ApplicationController
  def edit
    @profile = current_user

  end

  def show
    if current_user.type == "Owner"
      @cars = current_user.cars
    else
      @cars = nil
    end

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
