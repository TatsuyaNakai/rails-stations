class MoviesController < ApplicationController
  # GET /movies
  def index
    @movies = Movie.all

    if params[:keyword].present?
      @movies = @movies.merge(
        Movie.where('name LIKE ?', "%#{params[:keyword]}%")
        .or(Movie.where('description LIKE ?', "%#{params[:keyword]}%"))
      )
    end

    case params[:is_showing]
    when '1' then @movies = @movies.where(is_showing: true)
    when '2' then @movies = @movies.where(is_showing: false)
    end
  end

  # GET /movies/1
  def show
    today = Date.today

    @movie = Movie.find(params[:id])
    @dates = (0..6).map { |i| [l(today + i), (today + i).to_s] }
    @schedules = @movie.schedules
  end

  # GET movies/1/reservation
  def reservation
    # movie = Movie.find(params[:id])
    # @date = params[:date]
    # @schedule_id = movie.schedules.find(params[:schedule_id]).id
    @sheets = Sheet.all
  end
end
