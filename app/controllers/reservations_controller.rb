class ReservationsController < ApplicationController
  before_action :authenticate_user!

  # GET /movies/1/reservations/new
  def new
    return redirect_to movies_path, alert: '不正なURLです' if params[:date].blank? || params[:sheet_id].blank?

    set_related_records(params[:schedule_id], params[:sheet_id])
    @reservation = @schedule.reservations.build(date: params[:date], sheet_id: params[:sheet_id])
  end

  # POST /reservations
  def create
    set_related_records(params[:reservation][:schedule_id], params[:reservation][:sheet_id])
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.save
      redirect_to movies_path(@movie), notice: '予約が完了しました'
    elsif reserved_sheet?
      redirect_to(
        reservation_movie_path(id: @movie.id, schedule_id: @schedule.id, date: params[:reservation][:date]),
        notice: 'その座席はすでに予約済みです'
      )
    else
      render :new
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
    sheet_errors.find { |e| e[:error] == :taken }.present?
  end
end
