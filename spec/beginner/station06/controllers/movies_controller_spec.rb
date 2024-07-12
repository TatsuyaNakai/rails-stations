require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET /movies' do
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
end
