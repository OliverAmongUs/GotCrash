class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token #might be BAD
  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
    @bid = Bid.find(params[:id])
  end

  # GET /bids/new
  def new
    @bid = Bid.new
    @report_id = params[:report_id]
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)
    @bid[:fixer_id] = current_user.id
    @bid[:marked] = 0 #default false
    @bid[:ignored] = 0 #default false


    respond_to do |format|
      if @bid.save
        format.html { redirect_to fixer_bid_messages_path(current_user.id,@bid.id), notice: 'Bid was successfully created.' }
        #format.html { redirect_to fixer_bid_path(current_user,@bid), notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: fixer_bid_path(current_user,@bid) }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to fixer_bid_path(current_user,@bid), notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: fixer_bid_path(current_user,@bid)  }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/
  # DELETE /bids/
  def destroy
    @bid.messages.destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to fixer_bids_path(current_user), notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def choosereport
    @reports = Report.where(completed:0)
    gon.fixer_address = current_user.address
    gon.reports = @reports
  end

  def showreport
    @report = Report.find(params[:report_id])
    @car = Car.find(@report.car_id)
    @distance = params[:distance]
    respond_to do |format|
      format.js
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:description, :cost,:report_id)
    end
end
