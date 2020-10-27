require 'rails_helper'

RSpec.describe 'ベストタイム登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  context 'ベストタイムを登録できるとき' do
    it '各距離の登録ボタンを押すと、その距離のベストタイムを登録できる' do
      # ログインする
      sign_in(@user)
      # マイページへ遷移する
      visit user_path(@user)
      # 現在のユーザー名・ユーザー情報編集ボタンが表示されている
      expect(page).to have_selector('.user-show-name')
      expect(page).to have_content(@user.nickname.to_s)
      expect(page).to have_link 'プロフィールの編集', href: edit_user_registration_path(@user)
      # ベストタイムの「登録」「編集」、走力一覧ページへのボタンがある
      expect(page).to have_link '登録', href: new_record_path
      expect(page).to have_link '編集', href: edit_record_path(@user)
      expect(page).to have_link "#{@user.nickname}の走力を一覧表で確認", href: user_vdots_path(@user)
      # ベストタイム登録ページへ遷移する。
      visit new_record_path
      # 5kmの登録を押すと、FiveKmRecordモデルのカウントが1上がる
      expect do
        all('input[name="commit"]')[0].click
      end.to change { FiveKmRecord.count }.by(1)
      # ベストタイム登録ページへ遷移する。
      expect(current_path).to eq new_record_path
      # 10kmの登録を押すと、TenKmRecordモデルのカウントが1上がる
      expect do
        all('input[name="commit"]')[0].click
      end.to change { TenKmRecord.count }.by(1)
      # ベストタイム登録ページへ遷移する。
      expect(current_path).to eq new_record_path
      # ハーフマラソンの登録を押すと、HalfRecordモデルのカウントが1上がる
      expect do
        all('input[name="commit"]')[0].click
      end.to change { HalfRecord.count }.by(1)
      # ベストタイム登録ページへ遷移する。
      expect(current_path).to eq new_record_path
      # フルマラソンの登録を押すと、FullRecordモデルのカウントが1上がる
      expect do
        all('input[name="commit"]')[0].click
      end.to change { FullRecord.count }.by(1)
      # ベストタイム登録ページへ遷移し、「全てのベストタイムを登録済みです！」と表示されている
      expect(current_path).to eq new_record_path
      expect(page).to have_content('全てのベストタイムを登録済みです！')
      # マイページへのボタンをクリックし、自分のマイページへ遷移する
      find_link('マイページへ').click
      expect(current_path).to eq user_path(@user)
      # 0時間 0分 0秒と表示されている
      expect(page).to have_content('0時間 0分 0秒')
    end
  end

  context 'ベストタイムを登録できないとき' do
    it 'ログインしたユーザーは、自分以外のマイページでベストタイム登録ができない' do
      # ログインする
      sign_in(@user1)
      # 別のユーザーのマイページへ遷移する
      visit user_path(@user2)
      # ベストタイム「登録」「編集」のボタンが表示されていなく、走力一覧ページへのボタンが表示されている
      expect(page).to have_no_link '登録', href: new_record_path
      expect(page).to have_no_link '編集', href: edit_record_path(@user2)
      expect(page).to have_link "#{@user2.nickname}の走力を一覧表で確認", href: user_vdots_path(@user2)
    end
    it 'ログインしていないユーザーは、マイページでベストタイム登録ができない' do
      # トップページに遷移する
      visit root_path
      # 別のユーザーのマイページへ遷移する
      visit user_path(@user1)
      # ベストタイム関連の、4つのボタン（練習・登録・編集・削除）の内、VDOTボタンしか表示されていない
      expect(page).to have_no_link '登録', href: new_record_path
      expect(page).to have_no_link '編集', href: edit_record_path(@user1)
      expect(page).to have_no_link "#{@user.nickname}の走力を一覧表で確認", href: user_vdots_path(@user1)
    end
  end
end

RSpec.describe 'ベストタイム編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @five = FactoryBot.create(:five_km_record)
    @ten = FactoryBot.create(:ten_km_record)
    @half = FactoryBot.create(:half_record)
    @full = FactoryBot.create(:full_record)
  end

  # 自分以外のマイページでは、編集ボタンが表示されないことを、ベストタイム登録テストで確認済み

  context 'ベストタイムの編集ができるとき' do
    it '5kmのベストタイムを登録しているユーザーが、自分の5kmのベストタイムを編集できる' do
      # 5kmのベストタイムが登録してあるユーザーでログインする
      sign_in(@five.user)
      # マイページへ遷移する
      visit user_path(@five.user)
      # 編集ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@five.user)
      # 削除ボタンがある
      expect(page).to have_content('削除')
      # 5kmの編集を押しても、FiveKmRecordモデルのカウントは変わらない
      expect do
        all('input[name="commit"]')[0].click
      end.to change { FiveKmRecord.count }.by(0)
      # ベストタイム編集ページへ遷移する。
      expect(current_path).to eq edit_record_path(@five.user)
      # マイページへ遷移する
      visit user_path(@five.user)
      # 0分 1秒と表示されていて、0時間は表示されていない
      expect(page).to have_no_content('0時間')
      expect(page).to have_content('0分')
      expect(page).to have_content('1秒')
    end

    it '10kmのベストタイムを登録しているユーザーが、自分の10kmのベストタイムを編集できる' do
      # 10kmのベストタイムが登録してあるユーザーでログインする
      sign_in(@ten.user)
      # マイページへ遷移する
      visit user_path(@ten.user)
      # 編集ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@ten.user)
      # 削除ボタンがある
      expect(page).to have_content('削除')
      # 10kmの編集を押しても、TenKmRecordモデルのカウントは変わらない
      expect do
        all('input[name="commit"]')[0].click
      end.to change { FiveKmRecord.count }.by(0)
      # ベストタイム編集ページへ遷移する。
      expect(current_path).to eq edit_record_path(@ten.user)
      # マイページへ遷移する
      visit user_path(@ten.user)
      # 0分 1秒と表示されていて、0時間は表示されていない
      expect(page).to have_no_content('0時間')
      expect(page).to have_content('0分')
      expect(page).to have_content('1秒')
    end

    it 'ハーフのベストタイムを登録しているユーザーが、自分のハーフのベストタイムを編集できる' do
      # ハーフのベストタイムが登録してあるユーザーでログインする
      sign_in(@half.user)
      # マイページへ遷移する
      visit user_path(@half.user)
      # 編集ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@half.user)
      # 削除ボタンがある
      expect(page).to have_content('削除')
      # ハーフの編集を押しても、HalfRecordモデルのカウントは変わらない
      expect do
        all('input[name="commit"]')[0].click
      end.to change { HalfRecord.count }.by(0)
      # ベストタイム編集ページへ遷移する。
      expect(current_path).to eq edit_record_path(@half.user)
      # マイページへ遷移する
      visit user_path(@half.user)
      # 0分 1秒と表示されていて、0時間は表示されていない
      expect(page).to have_content('0時間')
      expect(page).to have_content('1分')
      expect(page).to have_content('2秒')
    end

    it 'フルのベストタイムを登録しているユーザーが、自分のフルのベストタイムを編集できる' do
      # フルのベストタイムが登録してあるユーザーでログインする
      sign_in(@full.user)
      # マイページへ遷移する
      visit user_path(@full.user)
      # 編集ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@full.user)
      # 削除ボタンがある
      expect(page).to have_content('削除')
      # フルの編集を押しても、FullRecordモデルのカウントは変わらない
      expect do
        all('input[name="commit"]')[0].click
      end.to change { FiveKmRecord.count }.by(0)
      # ベストタイム編集ページへ遷移する。
      expect(current_path).to eq edit_record_path(@full.user)
      # マイページへ遷移する
      visit user_path(@full.user)
      # 0分 1秒と表示されていて、0時間は表示されていない
      expect(page).to have_content('0時間')
      expect(page).to have_content('1分')
      expect(page).to have_content('2秒')
    end
  end
end

RSpec.describe 'ベストタイム削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @five = FactoryBot.create(:five_km_record)
    @ten = FactoryBot.create(:ten_km_record)
    @half = FactoryBot.create(:half_record)
    @full = FactoryBot.create(:full_record)
  end

  # 自分以外のマイページでは、削除ボタンが表示されないことを、ベストタイム登録テストで確認済み

  context 'ベストタイムの削除' do
    it '5kmのベストタイムを登録しているユーザーが、自分の5kmのベストタイムを削除できる' do
      # 5kmのベストタイムが登録してあるユーザーでログインする
      sign_in(@five.user)
      # マイページへ遷移する
      visit user_path(@five.user)
      # 削除ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@five.user)
      # 5kmの削除を押すと、FiveKmRecordモデルのカウントが1下がる
      expect do
        find_link('削除').click
      end.to change { FiveKmRecord.count }.by(-1)
      # ベストタイム編集ページへ遷移する。
      expect(current_path).to eq edit_record_path(@five.user)
      # 「ベストタイムを登録しましょう！」の文章と、登録ページへのボタンがある
      expect(page).to have_content('ベストタイムを登録しましょう！')
      expect(page).to have_link '登録ページへ', href: new_record_path
      # 登録ページへのボタンをクリックすると、ベストタイム登録ページへ遷移する
      find_link('登録ページへ').click
      expect(current_path).to eq new_record_path
    end

    it '10kmのベストタイムを登録しているユーザーが、自分の10kmのベストタイムを削除できる' do
      # 10kmのベストタイムが登録してあるユーザーでログインする
      sign_in(@ten.user)
      # マイページへ遷移する
      visit user_path(@ten.user)
      # 削除ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@ten.user)
      # 5kmの削除を押すと、FiveKmRecordモデルのカウントが1下がる
      expect do
        find_link('削除').click
      end.to change { TenKmRecord.count }.by(-1)
    end

    it 'ハーフのベストタイムを登録しているユーザーが、自分のハーフのベストタイムを削除できる' do
      # ハーフのベストタイムが登録してあるユーザーでログインする
      sign_in(@half.user)
      # マイページへ遷移する
      visit user_path(@half.user)
      # 削除ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@half.user)
      # 5kmの削除を押すと、FiveKmRecordモデルのカウントが1下がる
      expect do
        find_link('削除').click
      end.to change { HalfRecord.count }.by(-1)
    end

    it 'フルkmのベストタイムを登録しているユーザーが、自分のフルのベストタイムを削除できる' do
      # フルのベストタイムが登録してあるユーザーでログインする
      sign_in(@full.user)
      # マイページへ遷移する
      visit user_path(@full.user)
      # 削除ボタンをクリックし、ベストタイム編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_record_path(@full.user)
      # 5kmの削除を押すと、FiveKmRecordモデルのカウントが1下がる
      expect do
        find_link('削除').click
      end.to change { FullRecord.count }.by(-1)
    end
  end
end
