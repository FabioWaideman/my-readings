class BookmarksController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @bookmark = Bookmark.new(user: current_user, book: @book)
    authorize @bookmark
    @bookmark.save
    sleep 2
    redirect_to current_user
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @bookmark.destroy
    redirect_to current_user, status: :see_other
  end

  def mark_as_read
    @bookmark = Bookmark.find(params[:bookmark_id])
    authorize @bookmark
    if @bookmark["read"] == true
      @bookmark["read"] = false
    else
      @bookmark["read"] = true
    end
    @bookmark.save
    sleep 2
    redirect_to current_user, status: :see_other
  end
end
