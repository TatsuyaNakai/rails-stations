require 'rails_helper'

RSpec.describe Admin::MoviesController, type: :controller do
  describe 'GET /admin/movies' do
    before do
      @movie1 = FactoryBot.create(:movie)
      @movie2 = FactoryBot.create(:movie)
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
  end

  describe 'GET /admin/movies/new' do
    it '正常にレスポンスを返すこと' do
      get :new
      expect(response).to be_successful
    end

    it 'は、HTMLのレスポンスを返すこと' do
      get :new
      expect(response.content_type).to include('text/html')
    end
  end

  describe 'POST /admin/movies' do
    context '正しいパラメータのとき' do
      it 'は、作品の追加ができること' do
        movie_params = FactoryBot.attributes_for(:movie)
        expect { post :create, params: { movie: movie_params } }.to change(Movie, :count).by(1)
      end
    end

    context '不正なパラメータのとき' do
      before do
        movie = FactoryBot.create(:movie)
        movie_params = FactoryBot.attributes_for(:movie, name: movie.name)

        post :create, params: { movie: movie_params }
      end

      it 'は、422を返却すること' do
        expect(response).to have_http_status '422'
      end

      it 'は、新規作成画面を表示すること' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /admin/movies/:id/edit' do
    let!(:movie) { FactoryBot.create(:movie) }

    it 'は、正常にレスポンスを返すこと' do
      get :edit, params: { id: movie.id }
      expect(response).to be_successful
    end

    it 'は、HTMLのレスポンスを返すこと' do
      get :edit, params: { id: movie.id }
      expect(response.content_type).to include('text/html')
    end
  end

  describe 'PATCH /admin/movies/:id/' do
    let!(:movie) { FactoryBot.create(:movie) }

    context '正しいパラメータのとき' do
      it 'は、作品の更新ができること' do
        movie_params = FactoryBot.attributes_for(:movie)
        patch :update, params: { id: movie.id, movie: movie_params }

        expect(movie.reload.name).to eq(movie_params[:name])
      end
    end

    context '不正なパラメータのとき' do
      before do
        other_movie = FactoryBot.create(:movie)
        movie_params = FactoryBot.attributes_for(:movie, name: other_movie.name)

        patch :update, params: { id: movie.id, movie: movie_params }
      end

      it 'は、422を返却すること' do
        expect(response).to have_http_status '422'
      end

      it 'は、新規作成画面を表示すること' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /admin/movies/:id/' do
    context 'データが存在するとき' do
      let!(:movie) { FactoryBot.create(:movie) }
      it 'は、対象のレコードが削除されること' do
        expect { delete :destroy, params: { id: movie.id } }.to change(Movie, :count).by(-1)
      end
    end

    context 'データが存在しないとき' do
      it 'は、400を返すこと' do
        expect { delete :destroy, params: { id: 100 } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
