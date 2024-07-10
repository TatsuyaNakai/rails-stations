namespace :user do
  task remind_reservations: :environment do
    reservations = Reservation.includes(schedule: [:screen, :movie]).where(date: Date.tomorrow)
    mail_list = reservations.each_with_object([]) do |reservation, ary|
      index = ary.find_index { |elm| elm[:user_id] == reservation.user_id }
      if index
        ary[index][:reservations] << reservation
      else
        ary << { user_id: reservation.user_id, reservations: [reservation] }
      end
    end

    mail_list.each { |elm| UserMailer.remind_reservations(elm[:user_id], elm[:reservations]).deliver_now }
  end
end
