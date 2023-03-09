class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @books = Book.all
    authorize @books
    if params[:query].present?
      @books = @books.where("title ILIKE ?", "%#{params[:query]}%")
    end
  end
end
