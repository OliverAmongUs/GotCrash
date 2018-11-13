class ProfilesController < ApplicationController
  def edit
    @profile = current_user

  end

  def show
    if logged_in?
      @profile ||= current_user
      @user2 = @profile


    else
      redirect_to login_path
    end


  end

end
