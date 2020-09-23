require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @message = FactoryBot.build(:message)
  end

  # ログインしていないユーザーは、コメント投稿フォームが表示されないことを確認済み

  it 'ログインしたユーザーはツイート詳細ページでコメントを投稿できる' do
    # ログインする
    sign_in(@tweet.user)
    # ツイート詳細ページに遷移する
    visit tweet_path(@tweet)
    # フォームに情報を入力する
    fill_in 'text', with: @message.text
    # コメントを送信すると、Messageモデルのカウントが1上がる
    expect  do
      find('input[name="commit"]').click
      sleep 1
    end.to change {Message.count}.by(1)
    # コメント内容と「あなたのコメントです」と表示されている
    visit tweet_path(@tweet)
    expect(page).to have_content(@message.text)
    expect(page).to have_content('あなた のコメントです')
  end
end
