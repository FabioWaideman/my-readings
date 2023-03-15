class BooksController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]

  def index
    @books = policy_scope(Book).all
    authorize @books
    if params[:query].present?
      @books = @books.where("title ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    @book = Book.find(params[:id])
    authorize @book
    @review = Review.new
    @same_author_books = Book.where(author: @book.author).where.not(id: @book.id)
  end
end
