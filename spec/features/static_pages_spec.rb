require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe "Top page" do
    before do
      visit root_path   # 名前付きルートを使用
    end

    # タイトルが正しく表示されていること
    it "should have the right title" do
      expect(page).to have_title full_title('')
    end
  end
end
