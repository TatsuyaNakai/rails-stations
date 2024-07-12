require 'rails_helper'

RSpec.describe Admin::SchedulesController, type: :controller do
  describe 'PATCH /admin/schedules/:id' do
    let!(:movie) { FactoryBot.create(:movie) }
    let!(:screen) { FactoryBot.create(:screen) }
    let!(:schedule) { FactoryBot.create(:schedule, movie: movie, screen: screen) }

    it 'は、スケジュールの更新ができること' do
      end_time = Time.current.change(usec: 0)
      patch :update, params: { id: schedule.id, schedule: { end_time: end_time } }

      expect(schedule.reload.end_time).to eq(end_time)
    end
  end

  describe 'DELETE /admin/schedule/:id' do
    let!(:movie) { FactoryBot.create(:movie) }
    let!(:screen) { FactoryBot.create(:screen) }
    let!(:schedule) { FactoryBot.create(:schedule, movie: movie, screen: screen) }

    it 'は、レコードが削除されていること' do
      expect { delete :destroy, params: { id: schedule.id } }.to change(Schedule, :count).by(-1)
    end
  end
end
