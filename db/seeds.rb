# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'json'

key = ENV["BOOK_API_KEY"]

categories = ["fantasy",
              "children",
              "adventure",
              "science fiction",
              "art", "thriller",
              "suspense",
              "horror",
              "mystery",
              "romance"]

Book.destroy_all

categories.each do |c|
  url = "https://www.googleapis.com/books/v1/volumes?q=+subject:#{c}&maxResults=40&key=#{key}"
  fetch = Net::HTTP.get(URI(url))
  parse = JSON.parse(fetch)
  response = parse['items']
  if response.nil?
    puts "No results found for category #{c}"
  else
    response.each do |element|
      book = Book.new
      book.title = element["volumeInfo"]["title"]
      # element["volumeInfo"]["subtitle"].nil? ? book.subtitle = "" : book.subtitle = element["volumeInfo"]["imageLinks"]["smallThumbnail"]
      book.author = element["volumeInfo"]["authors"].nil? ? "Author not found" : element["volumeInfo"]["authors"].first
      book.average_rating = element["volumeInfo"]["averageRating"].nil? ? 0 : element["volumeInfo"]["averageRating"]
      element["volumeInfo"]["imageLinks"].nil? ? book.image_url = ActionController::Base.helpers.asset_path("dummybook.png") : book.image_url = element["volumeInfo"]["imageLinks"]["smallThumbnail"]
      book.page_count = element["volumeInfo"]["pageCount"]
      book.description = element["volumeInfo"]["description"]
      book.categories = element["volumeInfo"]["categories"]
      book.published_date = element["volumeInfo"]["publishedDate"]
      book.save!
    end
  end
end
