require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new, article: (1..10).to_a.sample
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates new comment" do
      count1 = Comment.count
      post :create, { comment: {article: (1..10).to_a.sample, author: Faker::Name.first_name , body: Faker::Hacker.say_something_smart } }
      count2 = Comment.count
      expect(count1).not_to be count2
    end
  end

end
