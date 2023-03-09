class ReviewsController < ApplicationController
  def index
    @products = policy_scope(Review)
  end
end
