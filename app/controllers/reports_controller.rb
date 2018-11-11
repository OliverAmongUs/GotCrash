class ReportsController < ApplicationController

  def index
    @reports = Report.find_by_owner_id(current_user.id)
  end

  def new
    @report = Report.new
  end

  def show
    set_report
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

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def model_params
      params.require(:report).permit(:car_id, :address, :description, :privacy, :picture_url, :picture_url_cache)
    end
end
