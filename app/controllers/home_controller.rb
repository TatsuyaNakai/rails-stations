class HomeController < ApplicationController
  def index
    @date_range = Date.today.ago(30.days)..Date.yesterday
    @movies = Movie.includes(:rankings)
  end
end
