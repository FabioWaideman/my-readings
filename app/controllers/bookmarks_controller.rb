class BookmarksController < ApplicationController
  def create
    @book = Book.find(params[:id])
    @bookmark = Bookmark.new(user: current_user, book: @book)
    @bookmark.save
  end
end
