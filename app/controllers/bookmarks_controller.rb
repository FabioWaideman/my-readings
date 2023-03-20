class BookmarksController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @bookmark = Bookmark.new(user: current_user, book: @book)
    authorize @bookmark
    @bookmark.save
    sleep 2
    respond_to do |format|
      format.html
      format.json { head => :no_content }
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @bookmark.destroy
    respond_to do |format|
      format.html
      format.json { head => :no_content }
    end
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
    respond_to do |format|
      format.html
      format.js {render inline: "location.reload();" }
    end
  end
end
