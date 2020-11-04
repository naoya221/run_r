require 'rails_helper'

RSpec.describe 'vdotページのコンテンツ閲覧', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  it 'ログインしていない場合の表示' do
    # トップページに遷移する
    visit root_path
    # ヘッダーナビの「走力一覧」ボタンより、走力一覧ページへ遷移する
    find_link('走力一覧').click
    # 説明案内が表示されている
    expect(page).to have_content 'ベストタイムを登録すると、該当する走力レベル部分が'
    expect(page).to have_content '※未登録ではレベル1にマーク'
    # 走力レベル一覧が表示されている（以下レベル1のみチェック）
    expect(page).to have_content('レベル：1')
    expect(page).to have_content('５km')
    expect(page).to have_content('１０km')
    expect(page).to have_content('ハーフ')
    expect(page).to have_content('フル')
    expect(page).to have_content('30分')
    expect(page).to have_content('40秒')
    expect(page).to have_content('63分')
    expect(page).to have_content('46秒')
    expect(page).to have_content('2時間')
    expect(page).to have_content('21分')
    expect(page).to have_content('04秒')
    expect(page).to have_content('4時間')
    expect(page).to have_content('49分')
    expect(page).to have_content('17秒')
    # 走力別の目安ペース一覧の案内（ドロップダウン）が表示されている
    expect(page).to have_content '各ペース（ E　M　T40　T20 ）とは？'
    # 走力別の目安ペース一覧が表示されている（以下レベル1のみチェック）
    expect(page).to have_content('E')
    expect(page).to have_content('M')
    expect(page).to have_content('T40')
    expect(page).to have_content('T20')
    expect(page).to have_content('7:52')
    expect(page).to have_content('6:51')
    expect(page).to have_content('6:36')
    expect(page).to have_content('6:24')
  end

  it 'ログインユーザーの場合の表示' do
    # ログインしする
    created_record(@user)
    # ヘッダーナビの「走力一覧」ボタンをクリック
    visit root_path
    find_link('走力一覧').click
    expect(current_path).to eq user_vdots_path(@user)
    # ユーザー名を含む案内が表示されている
    expect(page).to have_content("#{@user.nickname} さんの該当箇所に")
    # 走力別の目安ペース一覧の案内（ドロップダウン）が表示されている
    expect(page).to have_content '各ペース（ E　M　T40　T20 ）とは？'
    # 未ログイン時の説明案内が表示されていない
    expect(page).to have_no_content 'ベストタイムを登録すると、該当する走力レベル部分が'
    expect(page).to have_no_content '※未登録ではレベル1にマーク'
  end
end
