class BookmarksController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @bookmark = Bookmark.new(user: current_user, book: @book)
    authorize @bookmark
    @bookmark.save
    redirect_to current_user
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @bookmark.destroy
    redirect_to current_user
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark["read"] == true
      @bookmark["read"] = false
    else
      @bookmark["read"] = true
    end
    @bookmark.save
    redirect_to current_user
  end
end
