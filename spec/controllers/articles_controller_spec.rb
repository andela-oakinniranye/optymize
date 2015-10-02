require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :show, id: (1..10).to_a.sample
      expect(response).to have_http_status(:success)
    end
  end

end
