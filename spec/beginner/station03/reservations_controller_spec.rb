require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:user) { create(:user) }
  let(:screen) { create(:screen) }
  let(:movie) { create(:movie) }
  let(:schedule) do
    Schedule.create(
      screen_id: screen.id,
      movie_id: movie.id,
      start_time: Time.current,
      end_time: Time.current + 1.minutes
    )
  end
  let(:sheet) { Sheet.create(column: 'a', row: 1, screen_id: screen.id) }
  let(:valid_attributes) { { schedule_id: schedule.id, sheet_id: sheet.id, date: Date.today } }

  before do
    sign_in user
  end

  describe 'POST /reservation' do
    context '有効なパラメータを渡しているとき' do
      it 'は、新しい予約が作成されること' do
        expect { post :create, params: { reservation: valid_attributes } }.to change(Reservation, :count).by(1)
      end

      it 'は、確認メールが送信されること' do
        post :create, params: { reservation: valid_attributes }
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end

    context '既に座席が予約されているとき' do
      before do
        user.reservations.create(schedule_id: schedule.id, sheet_id: sheet.id, date: Date.today)
      end

      it '座席選択画面にリダイレクトすること' do
        post :create, params: { reservation: valid_attributes }

        expect(response).to redirect_to(
          reservation_movie_path(id: movie.id, schedule_id: schedule.id, date: Date.today)
        )
      end
    end

    context '無効なパラメータを渡しているとき' do
      it '/movies/1/reservations/new を表示すること' do
        allow_any_instance_of(Reservation).to receive(:save).and_return(false) # save時にfalseを返却
        post :create, params: { reservation: valid_attributes }

        expect(response).to render_template(:new)
      end
    end
  end
end
