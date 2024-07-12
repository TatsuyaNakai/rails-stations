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
    params = FactoryBot.attr
    post :create, params: {  }
  end
end
