class ReportsController < ApplicationController

  def index
    #@reports = Report.find_by_owner_id(current_user.id)
    @reports = current_user.reports
  end

  def new
    @report = Report.new
    @cars = current_user.cars
  end

  def edit
    @report = Report.find(params[:id])
    @cars = current_user.cars
  end

  def show
    set_report
    @bids = Bid.where(report_id: params[:id]).to_a
  end

  def create
    @report = Report.new(model_params)
    #@report = Report.new({:car_id => 1})
    #puts "current user is: #{current_user[:id]}"
    @report.completed = 0
    @report.owner_id = current_user[:id]
    # @report.picture_url = params[:file]
    #Report.update(:user_id => current_user[:id], :completed => 0)
    if @report.save
      flash[:success] = 'Upload a report successfully!'
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
    redirect_to '/reports'
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
