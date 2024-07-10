class ReservationMailerPreview < ActionMailer::Preview
  def confirm_email
    # /rails/mailers/reservation_mailer
    user = User.first
    reservation = user.reservations.first
    ReservationMailer.confirm_email(reservation)
  end
end
