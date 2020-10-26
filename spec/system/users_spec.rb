require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページ・走力一覧ページ・ログインページ（ログイン・かんたんログイン）・新規登録ページに遷移するボタンがある
      expect(page).to have_link 'Run Record', href: root_path
      expect(page).to have_link '走力一覧', href: vdots_path
      expect(page).to have_link 'かんたんログイン', href: new_user_session_path
      expect(page).to have_link 'ログイン', href: new_user_session_path
      expect(page).to have_link '新規登録', href: new_user_registration_path
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # # 新規登録ボタンを押すとuserモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # お知らせページ・マイページ・ログアウトボタンが表示されていて、ログインボタンや新規登録ボタンが表示されていない
      expect(page).to have_link 'お知らせ', href: notifications_path
      expect(page).to have_content @user.nickname
      expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      expect(page).to have_no_link 'ログイン', href: new_user_session_path
      expect(page).to have_no_link 'かんたんログイン', href: new_user_session_path
      expect(page).to have_no_link '新規登録', href: new_user_registration_path
      # ログアウトボタンをクリックし、再度トップページに遷移する
      find_link('ログアウト').click
      expect(current_path).to eq root_path
      # ログインページや新規登録ページへ遷移するボタンが表示されている
      expect(page).to have_link 'かんたんログイン', href: new_user_session_path
      expect(page).to have_link 'ログイン', href: new_user_session_path
      expect(page).to have_link '新規登録', href: new_user_registration_path
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 空のユーザー情報を入力する
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらない
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻される
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @gest
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
      all('input[name="commit"]')[0].click
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # 新規登録ボタン・ログインボタンが表示されていない
      expect(page).to have_no_link 'ログイン', href: new_user_session_path
      expect(page).to have_no_link 'かんたんログイン', href: new_user_session_path
      expect(page).to have_no_link '新規登録', href: new_user_registration_path
    end
  end

  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # ログインページへ遷移する
      visit new_user_session_path
      # 空のユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      all('input[name="commit"]')[1].click
      # ログインページへ戻される
      expect(current_path).to eq new_user_session_path
    end
  end
end
