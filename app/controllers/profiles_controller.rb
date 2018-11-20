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

end
