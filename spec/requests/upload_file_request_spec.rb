require 'rails_helper'

RSpec.describe 'UploadFiles', type: :request do

  describe 'Post /create' do
    it 'returns :found request without file' do
      post '/upload_files'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'Get /show/:id' do
    it 'returns http success' do
      upload_file = create(:upload_file)
      get "/upload_files/#{upload_file.id}"
      expect(response).to have_http_status(:ok)
    end
  end

end
