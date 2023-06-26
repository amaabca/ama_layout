describe AmaLayout::Api::V1::NotificationsController, type: :controller do
  routes { AmaLayout::Engine.routes }

  describe 'DELETE api/v1/notifications' do
    

    before(:each) do
      delete :dismiss_all
    end

    it 'returns a 204 No Content status' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
