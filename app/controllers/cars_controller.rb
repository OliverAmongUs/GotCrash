class CarsController < ApplicationController
  def new
    @car = Car.new
  end

  def edit
    @car = Car.find(params[:id])
  end

  def index
    @cars = current_user.cars
  end

  def show
    @car = Car.find(params[:id])
  end


  def create
    @car = Car.new(car_params)
    @car.owner_id = current_user.id
    if @car.save
      flash[:success] = 'create new car successfully'
      redirect_to @car
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
      @car = Car.find(params[:id])
      if @car.update(car_params)
        format.html { redirect_to cars_path, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { redirect_to edit_car_path }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      if(params.has_key?(:car))
        params.require(:car).permit(:make, :model, :year, :color, :vin, :licence, :picture_url, :picture_url_cache)
      end

    end


end
