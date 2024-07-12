RSpec.describe SheetsController, type: :controller do
  describe 'GET /sheets' do
    it 'は、正常にレスポンスを返すこと' do
      get :index
      expect(response).to be_successful
    end

    it 'は、HTMLのレスポンスを返すこと' do
      get :index
      expect(response.content_type).to include('text/html')
    end
  end
end
