class ReservationMailer < ApplicationMailer
  def confirm_email(reservation)
    @user = reservation.user
    @schedule = reservation.schedule
    @screen = @schedule.screen
    mail to: @user.email, subject: '【demo_app】予約確認メール'
  end
end
