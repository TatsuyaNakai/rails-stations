require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET /movies' do
    before do
      @movie1 = FactoryBot.create(:movie)
      @movie2 = FactoryBot.create(:movie, is_showing: false)
    end

    it 'は、正常にレスポンスを返すこと' do
      get :index
      expect(response).to be_successful
    end

    it 'は、HTMLのレスポンスを返すこと' do
      get :index
      expect(response.content_type).to include('text/html')
    end

    it 'は、映画一覧のページを返すこと' do
      get :index
      expect(assigns(:movies)).to match_array([@movie2, @movie1])
    end

    describe '検索機能' do
      it 'は、キーワードでの絞り込みができること' do
        get :index, params: { keyword: @movie1.name }

        expect(assigns(:movies)).to match_array([@movie1])
      end

      it 'は、公開ステータスでの絞り込みができること' do
        get :index, params: { is_showing: 2 }

        expect(assigns(:movies)).to match_array([@movie2])
      end
    end
  end

  describe 'GET /movies/:id' do
    let!(:movie) { FactoryBot.create(:movie) }

    it 'は、詳細情報が取得できること' do
      get :show, params: { id: movie.id }

      expect(assigns(:movie)).to match(movie)
    end

    it 'は、作品に関連するスケジュールが全件取得できること' do
      FactoryBot.create_list(:schedule, 3, movie: movie)

      get :show, params: { id: movie.id }
      expect(assigns(:schedules)).to match_array(movie.schedules)
    end
  end
end
