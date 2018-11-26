class ReviewsController < ApplicationController
  def new
    @review = Review.new

    @curFixer = current_user
    @curReport = current_report

    @review.fixer_id = @curFixer.id
    @review.report_id = @curReport.id

  end

  def show

    @review = Review.find(params[:id])
    @curFixer = current_user

  end

  def index
    @reviews = current_user.reviews
  end
end
