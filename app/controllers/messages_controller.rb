class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action do
   @bid = Bid.find(params[:bid_id])
  end

  # GET /messages
  # GET /messages.json
  def index
    
    @messages = @bid.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @bid.messages
    end
    @message = @bid.messages.new
  end

  def show
  end

  def new
    @message = @bid.messages.new
  end

  def edit
  end

  def create
    @message = @bid.messages.new(message_params)
    if @message.save
      redirect_to bid_messages_path(@bid)
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
