class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end




  # GET /users/1
  # GET /users/1.json
  def show
    set_user

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      @fUser = ForeignUser.new(user_id: @user.id, average_rating: 0)
      @fUser.save

      flash[:success] = 'Sign up successfully'
      log_in @user
      redirect_to '/profiles'
    else
      #params.delete :user
      #params.delete :owner
      render 'new'
      #redirect_to new_user_path, alert: 'You have an error in your submission.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profiles_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to profiles_edit_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
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
        params.require(:user).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation, :picture_url, :picture_url_cache, :terms)
      elsif (params.has_key?(:owner))
        params.require(:owner).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation, :picture_url, :picture_url_cache, :terms)
      else
        params.require(:fixer).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation, :picture_url, :picture_url_cache, :terms)
      end

    end

end
