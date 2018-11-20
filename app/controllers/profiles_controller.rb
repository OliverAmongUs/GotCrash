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

end
