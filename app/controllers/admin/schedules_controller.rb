module Admin
  class SchedulesController < AdminController
    before_action :set_movies, only: [:new, :edit]
    before_action :set_schedule, only: [:show, :edit, :update, :destroy]

    # GET /admin/schedules
    def index
      @movies = Movie.includes(:schedules)
    end

    # GET /admin/movies/1
    def show; end

    # GET /admin/schedules/new
    def new
      @schedule = Schedule.new
    end

    # GET /admin/schedules/1/edit
    def edit; end

    # POST /admin/schedules
    def create
      @schedule = Schedule.new(create_params)

      if @schedule.save
        redirect_to admin_schedules_path, notice: 'スケジュールを新規作成しました'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/schedules/1
    def update
      if @schedule.update(update_params)
        redirect_to admin_schedules_path, notice: 'スケジュールを更新しました'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/schedules/1
    def destroy
      if @schedule.destroy
        redirect_to admin_schedules_url, notice: 'スケジュールを削除しました'
      else
        redirect_to admin_schedules_url, alert: @schedule.errors.full_messages.join(', ')
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_movies
      @movies = Movie.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def common_params
      [:start_time, :end_time]
    end

    def create_params
      params.require(:schedule).permit(:movie_id, *common_params)
    end

    def update_params
      params.require(:schedule).permit(*common_params)
    end
  end
end
