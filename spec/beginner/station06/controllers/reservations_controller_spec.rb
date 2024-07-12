require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user

    @movie = FactoryBot.create(:movie)
    @screen = FactoryBot.create(:screen)
    @schedule = FactoryBot.create(:schedule, movie: @movie, screen: @screen)
    Sheet.create_sheets_for_screen!(@screen)
  end

  describe 'GET /movies/:id/schedules/:schedule_id/sheets' do
    context ':date, :sheet_id のパラメータが存在しないとき' do
      it 'は、作品一覧へリダイレクトすること' do
        get :new, params: { movie_id: @movie.id }
        expect(response.status).to eq 302
      end
    end

    context ':date, :sheet_id のパラメータが存在するとき' do
      it 'は、正常にレスポンスを返すこと' do
        sheet = Sheet.first
        get :new, params: { movie_id: @movie.id, sheet_id: sheet.id, schedule_id: @schedule.id, date: Date.today }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /reservation' do
    context '正しいパラメータのとき' do
      it '予約レコードが追加されること' do
        sheet = Sheet.first
        reservation_params = FactoryBot.attributes_for(:reservation)
        params = reservation_params.merge({ sheet_id: sheet.id, schedule_id: @schedule.id, date: Date.today })
        expect { post :create, params: { reservation: params } }.to change(Reservation, :count).by(1)
      end
    end

    context '不正なパラメータのとき' do
      context '不正なデータをパラメータに使用するとき' do
        it 'エラーとなること' do
          params = { reservation: { schedule_id: 100 } }
          expect { post :create, params: params }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context '座席が既に予約されているとき' do
        let!(:reservation) { FactoryBot.create(:reservation, sheet: Sheet.first, schedule: @schedule, user: @user) }

        it 'リダイレクトすること' do
          post :create, params: { reservation: reservation.attributes }
          expect(response.status).to eq 302
        end
      end
    end
  end
end
