class HomeController < ApplicationController
  def index
    date_range = Date.today.ago(30.days)..Date.yesterday
    @ranking_count = Ranking.preload(:movie).total_reservations_by_movie(date_range)
  end
end
