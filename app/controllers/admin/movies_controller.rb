module Admin
  class MoviesController < AdminController
    before_action :set_movies, only: %i[index new_schedule show_schedule]
    before_action :set_movie, only: %i[show edit update destroy new_schedule]

    # GET /admin/movies
    def index; end

    # GET /admin/movies/1
    def show; end

    # GET /admin/movies/new
    def new
      @movie = Movie.new
    end

    # GET /admin/movies/1/edit
    def edit; end

    # POST /admin/movies
    def create
      @movie = Movie.new(movie_params)

      if @movie.save
        redirect_to admin_movies_path, notice: '作品を新規作成しました'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/movies/1
    def update
      if @movie.update(movie_params)
        redirect_to admin_movies_path, notice: '作品を更新しました'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/movies/1
    def destroy
      if @movie.destroy
        redirect_to admin_movies_url, notice: '作品を削除しました'
      else
        redirect_to admin_movies_url, alert: @movie.errors.full_messages.join(', ')
      end
    end

    # GET /admin/movies/1/schedules/new
    def new_schedule
      @schedule = @movie.schedules.build
    end

    # GET /admin/movies/1/schedules/1
    def show_schedule
      movie = Movie.find(params[:movie_id])
      @schedule = movie.schedules.find(params[:schedule_id])
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_movies
      @movies = Movie.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
    end
  end
end
