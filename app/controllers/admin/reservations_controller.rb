module Admin
  class ReservationsController < AdminController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]

    # GET /admin/reservations
    def index
      @reservations = Reservation.preload(:sheet, schedule: :movie).order(created_at: :desc)
    end

    # GET /admin/reservations/new
    def new
      @reservation = Reservation.new
    end

    # GET /admin/reservations/1
    def show; end

    # GET /admin/reservations/1/edit
    def edit; end

    # POST /admin/reservations
    def create
      @reservation = Reservation.new(reservation_params)

      if @reservation.save
        redirect_to admin_reservations_path, notice: '予約を新規作成しました'
      else
        render :new, status: :bad_request
      end
    end

    # PATCH/PUT /admin/reservations/1
    def update
      if @reservation.update(reservation_params)
        redirect_to admin_reservations_path, notice: '予約を更新しました'
      else
        render :edit, status: :bad_request
      end
    end

    # DELETE /admin/reservations/1
    def destroy
      if @reservation.destroy
        redirect_to admin_reservations_url, notice: '予約を削除しました'
      else
        redirect_to admin_reservations_url, alert: @reservation.errors.full_messages.join(', ')
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :email, :name)
    end
  end
end
