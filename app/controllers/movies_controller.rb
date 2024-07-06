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
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end
end
