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
      @schedule = Schedule.new(schedule_params)

      if @schedule.save
        redirect_to admin_schedules_path, notice: "Scheduleを新規作成しました"
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/schedules/1
    def update
      if @schedule.update(schedule_params)
        redirect_to admin_schedules_path, notice: "Scheduleを更新しました"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/schedules/1
    def destroy
      if @schedule.destroy
        redirect_to admin_schedules_url, notice: "Scheduleを削除しました"
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
    def schedule_params
      params.require(:schedule).permit(:name, :year, :description, :image_url, :is_showing)
    end
  end
end
