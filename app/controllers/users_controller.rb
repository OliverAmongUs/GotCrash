class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show()
    set_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Sign up successfully'
      render root_url
    else
      #params.delete :user
      params.delete :owner
      render 'new'
      #redirect_to new_user_path, alert: 'You have an error in your submission.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
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
      byebug
      if(params.has_key?(:user))
        params.require(:user).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation)
      elsif (params.has_key?(:owner))
        params.require(:owner).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation)
      else
        params.require(:fixer).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation)
      end
        #params.permit(:name, :email, :address, :phone, :type, :password, :password_confirmation, :user)
        # params.require(params[:type].to_sym).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation)
        # key = (params.keys & %w(owner fixer))[0]
        # params.require(key).permit(:name, :email, :address, :phone, :type, :password, :password_confirmation)
    end

end
