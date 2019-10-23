require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # nameがなければ無効,50文字以内
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_most(50)}

  # usernameがなければ無効、50文字以内
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_length_of(:username).is_at_most(50)}
  # 重複したusernameなら無効
  it 'is invalid with a duplicate username' do
    FactoryBot.create(:user, username: "hogehoge")
    user = FactoryBot.build(:user, username: "hogehoge")
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
  end

  # メールアドレスがなければ無効
  it { is_expected.to validate_presence_of(:email) }
  
  # 重複したメールアドレスなら無効 
  it "is invalid with a duplicate email adress" do 
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "Aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  # メールアドレスの有効性
  describe "email validation should reject invalid addresses" do
    # 無効なメールアドレスの場合
    it "should be invalid" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
                            foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end
  
    # 有効なメールアドレスの場合
    it "should be valid" do
      valid_addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  #パスワードがなければ無効な状態である
  subject { User.new(password: '123456') }
  it { is_expected.to validate_presence_of(:password) }
  
  #パスワードが一致しなければ無効
  it "is invalid when password confirmation doesn't match password" do
    user = FactoryBot.build(:user, password: "password", password_confirmation: "different")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end
end
