class ReservationsController < ApplicationController
  # GET /movies/1/reservations/new
  def new
    set_related_records(params[:schedule_id], params[:sheet_id])
    @reservation = @schedule.reservations.build(date: params[:date], sheet_id: params[:sheet_id])
  end

  # POST /movies/1/reservations
  def create
    set_related_records(params[:reservation][:schedule_id], params[:reservation][:sheet_id])
    @reservation = @schedule.reservations.build(reservation_params)

    if @reservation.save
      redirect_to movies_path(@movie), notice: '予約が完了しました'
    else
      if reserved_sheet?
        # /movies/:movie_id/reservation?schedule_id={schedule_id}&date=YYYY-MM-DDとは？
        redirect_to reservation_movie_path(
          id: @movie.id, schedule_id: @schedule.id, sheet_id: @sheet.id, date: params[:reservation][:date]
        ),
        notice: 'その座席はすでに予約済みです'
      else
        render :new
      end
    end
  end

  private

  def set_related_records(schedule_id, sheet_id)
    @schedule = Schedule.find(schedule_id)
    @movie = @schedule.movie
    @sheet = Sheet.find(sheet_id)
  end

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :email, :name)
  end

  def reserved_sheet?
    sheet_errors = @reservation.errors.details[:sheet]
    sheet_errors.find { |e| e[:error] === :taken }.present?
  end
end
