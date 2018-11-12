class ReportsController < ApplicationController

  def index
    @reports = Report.find_by_owner_id(current_user.id)
  end

  def new
    @report = Report.new
  end

  def edit
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

  def update
    respond_to do |format|
      if @report.update(model_params2)
        format.html { redirect_to reports_path, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { redirect_to reports_edit_path }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def model_params
      params.require(:report).permit(:car_id, :address, :description, :privacy, :picture_url, :picture_url_cache)
    end

    def model_params2
      params.require(:report).permit(:car_id, :address, :description, :privacy)
    end
end
