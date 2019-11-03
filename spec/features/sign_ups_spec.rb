require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  include ActiveJob::TestHelper

  # ユーザーはサインアップに成功する
  scenario "user successfully signs up" do
    visit root_path
    click_link "新規登録"
    perform_enqueued_jobs do
      expect {
        fill_in 'フルネーム',          with: "Example"
        fill_in "ユーザーネーム",       with: "testname"
        fill_in "メールアドレス",       with: "test@example.com"
        fill_in "パスワード",          with: "test123"
        fill_in "パスワード確認",       with: "test123"
        click_button "Sign up"
      }.to change(User, :count).by(1)

      #expect(current_path).to eq ユーザーページ
    end
  end
end
