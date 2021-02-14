require 'rails_helper'

RSpec.describe "Parliamentarians", type: :request do
  describe 'Get /show/:id' do
    it 'returns http success' do
      parliamentarian = create(:parliamentarian_with_expenditures)
      get "/parliamentarians/#{parliamentarian.id}"
      expect(response).to have_http_status(:ok)
    end
  end
end
