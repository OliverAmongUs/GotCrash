class ReviewsController < ApplicationController
   $aaa
   $bbb
  def new
    @review = Review.new

    # @curFixer = current_user
    # @curReport = current_report
    @review.fixer_id = params[:fixerID]
    @review.report_id = params[:reportID]

    $aaa = params[:fixerID]
    $bbb = params[:reportID]

    @curFixer = User.find(params[:fixerID])

  end

  def show
    @review = Review.find(params[:id])

    if current_user.type == 'fixer'
      @curFixer = current_user
    else
      @curFixer = User.find($aaa)
    end


  end

  def index
    @reviews = current_user.reviews
  end


  def create

    @review = Review.new(review_params)
    @review.fixer_id = $aaa
    @review.report_id = $bbb

    # if User.find(@review.fixer_id).type != 'fixer'
    #   break
    # end


    if @review.save
      flash[:success] = 'create new review successfully'
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
