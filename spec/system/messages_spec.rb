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
    fill_in 'text', with: @message
    # コメントを送信すると、Messageモデルのカウントが1上がる
    expect{
      find('input[name="commit"]').click
      sleep 1
    }.to change {Message.count}.by(1)
    # 「コメント内容  (コメントしました) と表示されている」
    expect(page).to have_content("#{@message}　　(コメントしました)")
    # リロードすると、コメント内容と「あなたのコメントです」と表示されている
    visit current_path
    expect(page).to have_content(@message)
    expect(page).to have_content("あなた のコメントです")
  end
end