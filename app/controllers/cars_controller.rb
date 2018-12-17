class CarsController < ApplicationController
  def new
    @car = Car.new
  end

  def search_vin
    puts params
    @car = Car.new
    if params[:vin] != '' && !params[:vin].nil?
      @car.vin = params[:vin]


      carData = VehicleAPI.new(params[:vin])
      @car.make, @car.model, @car.year, @car.vehicle_type, @car.body_class, @car.doors, @car.gross_vehicle_weight_rating,
      @car.transmission_style, @car.engine_number_of_cylinders, @car.engine_power, @car.fuel_type = carData.getDetail

    end
    puts("car is: #{@car}")
    respond_to do |format|
      format.js
    end
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
      render :js => "window.location.href='"+cars_path+"'"
      return
    else
      render 'new'
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
      format.html { redirect_to profiles_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      if(params.has_key?(:car))
        params.require(:car).permit(:make, :model, :year, :color, :vin, :licence, :picture_url, :picture_url_cache,
        :vehicle_type, :body_class, :doors, :gross_vehicle_weight_rating, :transmission_style, :engine_number_of_cylinders, :engine_power, :fuel_type)
      end

    end


end



class VehicleAPI
  include HTTParty

  def initialize(vin)
    @vin = vin
    aa = "https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVin/"+@vin+"?"
    bb = "format=json"
    request = HTTParty.get(aa+bb).to_json
    @request_hash = JSON.parse(request)
  end


  def getDetail
    @request_hash["Results"].each do |line|
      if line["Variable"] == "Make"
        @Make = line["Value"]
      end

      if line["Variable"] == "Model"
        @Model = line["Value"]
      end

      if line["Variable"] == "Model Year"
        @ModelYear = line["Value"]
      end

      if line["Variable"] == "Vehicle Type"
        @Vehicle_Type = line["Value"]
      end

      if line["Variable"] == "Body Class"
        @Body_Class = line["Value"]
      end

      if line["Variable"] == "Doors"
        @Doors = line["Value"]
      end

      if line["Variable"] == "Gross Vehicle Weight Rating"
        @Gross_Vehicle_Weight_Rating = line["Value"]
      end

      if line["Variable"] == "Transmission Style"
        @Transmission_Style = line["Value"]
      end

      if line["Variable"] == "Engine Number of Cylinders"
        @Engine_Number_of_Cylinders = line["Value"]
      end

      if line["Variable"] == "Engine Power (KW)"
        @Engine_Power = line["Value"]
      end

      if line["Variable"] == "Fuel Type - Primary"
        @Fuel_Type = line["Value"]
      end


    end
      return @Make, @Model, @ModelYear, @Vehicle_Type, @Body_Class, @Doors,
      @Gross_Vehicle_Weight_Rating, @Transmission_Style, @Engine_Number_of_Cylinders, @Engine_Power, @Fuel_Type

  end


# Vehicle Type, Body Class, Doors, Gross Vehicle Weight Rating, Transmission Style, Engine Number of Cylinders,
# Engine Power (KW), Fuel Type - Primary


end
