class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action do
   @bid = Bid.find(params[:bid_id])
   @fixer = User.find(@bid.fixer_id)
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
    current_user.notifications.each do |notification|
      if notification.bid.id == @bid.id
        notification.destroy
      end
    end
  end

  def show
  end

  def new
    @message = @bid.messages.new
  end

  def edit
  end

  def create
    message = @bid.messages.build(message_params)
    if message.save

      user = User.find(message.user_id)
      if current_user.type == "Owner" #sets up and sends to phone number
        @receiver_number = @bid.fixer.phone
        receiver = @bid.fixer
      else
        @receiver_number = @bid.owner.phone
        receiver = @bid.owner
      end
      if Rails.env.production? #texting costs money, so only use during production
        send_message(@receiver_number)
      end

      check = true
      receiver.notifications.each do |notification| #check if there is a notification for this bid
        if notification.bid.id == @bid.id
          check = false
          break
        end
      end
      if check == true #Sets up notifications if there isn't one already and action cable broadcast
        if current_user.id == message.bid.fixer.id
          Notification.create(user_id: message.bid.report.owner.id, bid_id: @bid.id, sender_id: @bid.owner.id)
        else
          Notification.create(user_id: message.bid.fixer.id, bid_id: @bid.id, sender_id: @bid.fixer.id)
        end
      end
      ActionCable.server.broadcast 'room_channel',
                                   body: message.body,
                                   sender: message.user_id,
                                   sender_name: user.name,
                                   picture: message.picture_url_url,
                                   user_picture: current_user.picture_url_url,
                                   time: message.created_at.strftime("%F %R"),
                                   count: receiver.notifications.count,
                                   receiver_id: receiver.id,
                                   fixer_id: @fixer.id,
                                   bid_id: @bid.id
                                   #message: render_message(message)
      #redirect_to fixer_bid_messages_path(@fixer, @bid)
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
      params.require(:message).permit(:body, :user_id, :picture_url, :picture_url_cache)
    end

    def send_message(phone)
      @alert_message = "You have an awaiting message on GotCrash!"
      @twilio_number = ENV['TWILIO_NUMBER']
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

      message = @client.messages.create(
        :from => @twilio_number,
        :to => "+1#{phone}",
        :body => @alert_message
        # US phone numbers can make use of an image as well.
        # :media_url => image_url
      )
    end
    def render_message(message)
      render(partial: 'newmessage', locals: { message: message })
    end
end
