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
    set_report
    @bids = Bid.where(report_id: params[:id]).to_a
  end


  def create

    @report = Report.new(model_params)

    @report.completed = 0
    @report.owner_id = current_user[:id]

    if @report.save
      flash[:success] = 'Upload a report successfully!'
      (1..14).each do |a|
        if params.key?(a.to_s)
          o = ReportJoinAuto.new(:report_id => @report.id, :auto_part_id => a)
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
        (1..14).each do |a|
          if params.key?(a.to_s)
            o = ReportJoinAuto.new(:report_id => @report.id, :auto_part_id => a)
            o.save
          end
        end
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


  def completeReport
    @allbids = params[:bids]
    @chosen = params[:chosen]
    @report = Report.find(params[:reportID])

    @allbids.each do |bid|
      if bid != @chosen
        Bid.find(bid).update(ignored: 1)
      else
        Bid.find(bid).update(marked: 1)
      end
    end
    @report.update(completed: 1)






    redirect_to @report
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
    end
  end

  def search_report

    @reports= current_user.reports
    if params["value"]!= ""
      if params["value"] == "0"
        @reports = current_user.reports
      elsif params["value"] == "1"
        @reports = current_user.reports.where(completed: 1)
      elsif params["value"] == "2"
        @reports = current_user.reports.where(completed: 0)
      end
    end
    puts @reports
    respond_to do |format|
      format.js
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
