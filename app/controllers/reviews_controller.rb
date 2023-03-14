class ReviewsController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @reviews = policy_scope(@book.reviews)
    authorize @reviews
    if params[:rating].present?
      @reviews = @reviews.where(rating: params[:rating])
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
    authorize @review
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to book_path(@book), notice: "Review was successfully created."
    else
      render :new
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    @review.book = @book
    @review.user = current_user
    authorize @review
    @review.destroy
    redirect_to book_path(@book), notice: 'Review was successfully deleted.'
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
