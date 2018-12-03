class ReportsController < ApplicationController

  def index
    #@reports = Report.find_by_owner_id(current_user.id)
    @reports = current_user.reports
  end

  def new
    @report = Report.new
    @cars = current_user.cars
    @APs = AutoPart.all
    # byebug
  end

  def edit
    @report = Report.find(params[:id])
    @cars = current_user.cars
    @APs = AutoPart.all
  end

  def show
    # byebug


    set_report

    # @a = params[:Bumper]
    @bids = Bid.where(report_id: params[:id]).to_a
    # @a = AutoPart.find(params[:Bumper][:id])
    # o = ReportJoinAutoPart.new(:report_id => params[:id], :AutoPart_id => '2')
    # o.save
    # byebug
  end


  def create

    @report = Report.new(model_params)

    @report.completed = 0
    @report.owner_id = current_user[:id]

    if @report.save
      flash[:success] = 'Upload a report successfully!'
      (1..8).each do |a|
        if params.key?(a.to_s)
          o = ReportJoinAuto.new(:report_id => @report.id, :auto_part_id => a)
          byebug
          o.save
        end
      end
      redirect_to @report
    else
      puts "something wrong"
      flash[:danger] = 'Upload a report failed!'
      render 'new'
    end
  end

  def update
    respond_to do |format|
      @report = Report.find(params[:id])
      if @report.update(model_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { redirect_to reports_edit_path }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_report
      @report = Report.find(params[:id])
    end


    def model_params
      params.require(:report).permit(:car_id, :address, :description, :privacy, :completed, :picture_url, :picture_url_cache, :longitude,:latitude)
    end

    def model_params2
      params.require(:report).permit(:car_id, :address, :description, :privacy, :completed)
    end
end
