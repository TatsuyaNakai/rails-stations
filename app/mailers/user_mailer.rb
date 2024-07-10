class UserMailer < ApplicationMailer
  def remind_reservations(user_id, reservations)
    @user = User.find(user_id)
    @reservations = reservations
    mail to: @user.email, subject: '【demo_app】前日確認メール'
  end
end
