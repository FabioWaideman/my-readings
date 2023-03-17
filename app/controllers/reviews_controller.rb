class ReviewsController < ApplicationController
  include ActionView::RecordIdentifier # adds `dom_id`
  before_action :set_book, only: [:create, :destroy, :new, :index]

  def index
    @reviews = policy_scope(@book.reviews)
    authorize @reviews
    if params[:rating].present?
      @reviews = @reviews.where(rating: params[:rating])
    end
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to book_path(@book), anchor: dom_id(@review)
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.book = @book
    @review.user = current_user
    authorize @review
    @review.destroy
    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
