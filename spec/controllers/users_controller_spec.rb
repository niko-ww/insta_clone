require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  
  describe "#show" do
    # ログインユーザーが
    context "login_user" do
      # 正常なレスポンスを返すこと
      it "responds successfully" do
        sign_in user
        get :show
        expect(response).to be_success
      end
    end

    # ログインしていないユーザーが
    context "guest_user" do 
      # ログイン画面にリダイレクトすること
      it "redirects to the login page" do
        get :show
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
