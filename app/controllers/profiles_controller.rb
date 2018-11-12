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


  # private
  #
  #
  #   def model_params
  #     if(params.has_key?(:user))
  #       params.require(:user).permit(:name, :email, :address, :phone, :picture_url, :picture_url_cache)
  #     elsif (params.has_key?(:owner))
  #       params.require(:owner).permit(:name, :email, :address, :phone, :type, :picture_url, :picture_url_cache)
  #     else
  #       params.require(:fixer).permit(:name, :email, :address, :phone, :type, :picture_url, :picture_url_cache)
  #     end
  #
  #   end

end





# task to complete:
# 1. add file upload
#   https://guides.rubyonrails.org/form_helpers.html#uploading-files
