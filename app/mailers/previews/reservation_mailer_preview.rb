class ReservationMailerPreview < ActionMailer::Preview
  # /rails/mailers/reservation_mailer
  def confirm_email
    user = User.first
    reservation = user.reservations.first
    ReservationMailer.confirm_email(reservation)
  end
end
