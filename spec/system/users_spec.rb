require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページ・練習ページ・新規登録ページ・ログインページに遷移するボタンがある
      expect(page).to have_content('Run Record')
      expect(page).to have_content('練習')
      expect(page).to have_content('ログイン')
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # # 新規登録ボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # マイページへのボタン・ログアウトボタンが表示されていて、ログインボタンや新規登録ボタンが表示されていない
      expect(page).to have_content("#{@user.nickname}：さん")
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
      # ログアウトボタンをクリックし、再度トップページに遷移する
      all(".nav-item")[2].click
      expect(current_path).to eq root_path
      # 新規登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されている
      expect(page).to have_content('ログイン')
      expect(page).to have_content('新規登録')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 空のユーザー情報を入力する
      fill_in 'user_nickname', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻される
      expect(current_path).to eq "/users"
    end
  end

end



RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # 新規登録ボタン・ログインボタンが表示されていない
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end

  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # ログインページへ遷移する
      visit new_user_session_path
      # 空のユーザー情報を入力する
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻される
      expect(current_path).to eq new_user_session_path
    end
  end
end 