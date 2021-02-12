require 'rails_helper'

RSpec.describe 'UploadFiles', type: :request do

  describe 'Post /create' do
    # it 'returns http success' do
    #   file = Tempfile.new(['file', '.csv'])
    #   file.write("id,name\n2,John Doe\n5,John Doe")
    #   post '/upload_files', params: { file: fixture_file_upload(file, 'text/csv') }
    #   expect(response).to have_http_status(:success)
    # end

    it 'returns http bad request' do
      post '/upload_files'
      expect(response).to have_http_status(:no_content)
    end
  end

end
