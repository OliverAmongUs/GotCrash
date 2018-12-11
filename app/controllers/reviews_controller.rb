class ReviewsController < ApplicationController
   $fixerID
   $reportID

  def new
    @review = Review.new

    # @curFixer = current_user
    # @curReport = current_report
    @review.fixer_id = params[:fixerID]
    @review.report_id = params[:reportID]

    $fixerID = params[:fixerID]
    $reportID = params[:reportID]

    @curFixer = User.find(params[:fixerID])

  end

  def show
    @review = Review.find(params[:id])

    if current_user.type == 'Fixer'
      @curFixer = current_user
    else
      @curFixer = User.find($fixerID)
    end


  end

  def index


    @reviews = current_user.reviews
  end


  def create

    @review = Review.new(review_params)
    @review.fixer_id = $fixerID
    @review.report_id = $reportID
    if @review.save

      flash[:success] = 'create new review successfully'
      updateFU = ForeignUser.where(user_id: @review.fixer_id)[0]
      numReview = Review.where(fixer_id: @review.fixer_id).count
      #byebug
      result = ((numReview - 1) * updateFU.average_rating + @review.rating) / numReview
      updateFU.update(average_rating: result)
      # updateFixer.assign_attributes(average_rating: (updateFixer.average_rating * numReview + @review.rating) / numReview)
      # updateFixer.average_rating = (updateFixer.average_rating * numReview + @review.rating) / numReview
      # byebug
      redirect_to @review
    else

      render 'new'
    end
  end



  private


    def review_params
      if(params.has_key?(:review))
        params.require(:review).permit(:fixer_id, :report_id, :rating, :description)
      end

    end


end
