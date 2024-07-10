require 'rails_helper'

RSpec.describe 'user:remind_reservations' do
  let(:user) { create(:user) }
  let(:screen) { FactoryBot.create(:screen) }
  let(:movie) { create(:movie) }
  let(:schedule) do
    tomorrow = Time.current.tomorrow
    Schedule.create(
      screen_id: screen.id,
      movie_id: movie.id,
      start_time: tomorrow,
      end_time: tomorrow + 1.minutes
    )
  end
  let(:sheet1) { Sheet.create(column: 'a', row: 1, screen_id: screen.id) }
  let(:sheet2) { Sheet.create(column: 'a', row: 2, screen_id: screen.id) }

  subject(:task) { Rake.application['user:remind_reservations'] }

  it 'は、明日映画を予約している会員に対してメールを送信すること' do
    user.reservations.create(schedule_id: schedule.id, sheet_id: sheet1.id, date: Date.tomorrow)
    user.reservations.create(schedule_id: schedule.id, sheet_id: sheet2.id, date: Date.tomorrow)

    task.invoke
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
