class UserMailerPreview < ActionMailer::Preview
  # /rails/mailers/user_mailer
  def remind_reservations
    user = User.first
    reservations = user.reservations.where(date: Date.tomorrow)
    UserMailer.remind_reservations(user.id, reservations)
  end
end
