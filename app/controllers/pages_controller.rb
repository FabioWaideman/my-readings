class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  layout 'landing_page'

  def home
  end
end
