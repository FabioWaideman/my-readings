class BookService < ApplicationService
  def initialize(query)
    @query = query
    @key = ENV["BOOK_API_KEY"]
  end

  def call
    unless @key.nil?
      url = "https://www.googleapis.com/books/v1/volumes?q=#{@query}&key=#{@key}"
      fetch = Net::HTTP.get(URI(url))
      response = JSON.parse(fetch)
      digest(response)
    end
  end

  def digest(response)
    books_list = []
    response["items"].each do |element|
      book = {}
      book[:id] = element["id"]
      book[:title] = element["volumeInfo"]["title"]
      book[:author] = element["volumeInfo"]["authors"].nil? ? "Author not found" : element["volumeInfo"]["authors"].first
      book[:rating] = element["volumeInfo"]["averageRating"].nil? ? 0 : element["volumeInfo"]["averageRating"]
      element["volumeInfo"]["imageLinks"].nil? ? book[:image_url] = ActionController::Base.helpers.asset_path("dummybook.png") : book[:image_url] = element["volumeInfo"]["imageLinks"]["smallThumbnail"]
      books_list.push(book)
    end
    return books_list
  end

  # def find
  #   unless @key.nil?
  #     url = "https://www.googleapis.com/books/v1/volumes/#{@query}?key=#{@key}"
  #     fetch = Net::HTTP.get(URI(url))
  #     response = JSON.parse(fetch)
  #     digest_one(response)
  #   end
  # end

  # def digest_one(response)
  #   debugger
  #   books_list = []
  #   response["items"].each do |element|
  #     book = {}
  #     book[:title] = element["volumeInfo"]["title"]
  #     book[:author] = element["volumeInfo"]["authors"].nil? ? "Author not found" : element["volumeInfo"]["authors"].first
  #     book[:rating] = element["volumeInfo"]["averageRating"].nil? ? 0 : element["volumeInfo"]["averageRating"]
  #     element["volumeInfo"]["imageLinks"].nil? ? book[:image_url] = ActionController::Base.helpers.asset_path("dummybook.png") : book[:image_url] = element["volumeInfo"]["imageLinks"]["smallThumbnail"]
  #     books_list.push(book)
  #   end
  #   return books_list
  # end

end
