require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  # ログインに成功し、ログアウトする
  scenario "user successfully login" do
    valid_login(user)

    #expect(current_path).to eq (user)
    expect(page).to_not have_content "Log in"

    # ログアウトのテスト
    click_link "Log out"

      expect(current_path).to eq root_path
      expect(page).to have_content "Log in"
  end

  # 無効な情報ではログインに失敗すること
  scenario "user doesn't login with invalid information" do
    visit root_path
    click_link "Log in"
    fill_in "メールアドレス", with: ""
    fill_in "パスワード", with: ""
    click_button "Log in"

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "Log in"
    expect(page).to have_content "Invalid Email or password."
  end

end
