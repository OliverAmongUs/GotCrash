class ProfilesController < ApplicationController
  def edit
    @profile = current_user

  end

  def show
    if logged_in?
      if current_user.type == "Owner"
        @cars = current_user.cars
      else
        @cars = nil
      end
      @profile ||= current_user
      @user2 = @profile
    else
      redirect_to login_path
    end
  end

  def update
    @profile = current_user
    if @profile.update_attributes(user_params)
      flash[:success] = 'Update successfully'
      redirect_to @profile
    else
      render 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if(params.has_key?(:user))
        params.require(:user).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation, :picture_url, :picture_url_cache)
      elsif (params.has_key?(:owner))
        params.require(:owner).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation, :picture_url, :picture_url_cache)
      else
        params.require(:fixer).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation, :picture_url, :picture_url_cache)
      end

    end
end
