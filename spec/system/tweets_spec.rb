require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
  end

  context '新規投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクをクリックし、新規投稿ページへ遷移する
      find_link('お気に入りコースをシェアしよう！').click
      expect(current_path).to eq new_tweet_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/dog2.png')

      fill_in 'tweet_place_name', with: @tweet.place_name
      attach_file('tweet[place_image]', image_path, make_visible: true)
      fill_in 'tweet_address', with: @tweet.address
      fill_in 'tweet_content', with: @tweet.content
      # 投稿するとTweetモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # トップページに遷移し、投稿した情報が存在する
      expect(current_path).to eq root_path
      expect(page).to have_content(@tweet.place_name)
      expect(page).to have_selector('.place-image')
      expect(page).to have_content(@tweet.address)
      expect(page).to have_content(@tweet.content)
    end
  end
  context '新規投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('お気に入りコースをシェアしよう！')
    end
    it '投稿内容が空だと投稿できない' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクをクリックし、新規投稿ページへ遷移する
      find_link('お気に入りコースをシェアしよう！').click
      expect(current_path).to eq new_tweet_path
      # フォームが空のまま、投稿ボタンを押してもTweetモデルのカウントが変わらない
      fill_in 'tweet_place_name', with: ""
      fill_in 'tweet_address', with: ""
      fill_in 'tweet_content', with: ""
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(0)
      # 新規投稿ページへ戻される
      expect(current_path).to eq ("/tweets")
    end
  end
end



RSpec.describe '投稿内容の編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context '投稿内容が編集できるとき' do
    it 'ログインしたユーザーは、自分が投稿した投稿内容を編集ができる' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@tweet1.user)
      # 投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 編集するボタンをクリックし、編集ページへ遷移する
      find_link('編集').click
      expect(current_path).to eq edit_tweet_path(@tweet1)
      # すでに投稿済みの内容がフォームに入っている
      expect(
        find('#tweet_place_name').value
      ).to eq @tweet1.place_name
      expect(page).to have_selector('.before_image')
      expect(
        find('#tweet_address').value
      ).to eq @tweet1.address
      expect(
        find('#tweet_content').value
      ).to eq @tweet1.content
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/place_image.png')

      fill_in 'tweet_place_name', with: "#{@tweet1.place_name}+編集OK!"
      attach_file('tweet[place_image]', image_path, make_visible: true)
      fill_in 'tweet_address', with: "#{@tweet1.address}+編集OK!"
      fill_in 'tweet_content', with: "#{@tweet1.content}+編集OK!"
      # 編集してもTweetモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change {Tweet.count}.by(0)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには編集した内容の投稿が存在する
      expect(page).to have_content("#{@tweet1.place_name}+編集OK!")
      expect(page).to have_selector('.place-image')
      expect(page).to have_content("#{@tweet1.address}+編集OK!")
      expect(page).to have_content("#{@tweet1.content}+編集OK!")
    end
  end
  context '投稿内容が編集できないとき' do
    it 'ログインしたユーザーは、自分以外が投稿した投稿の編集画面には遷移できない' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@tweet1.user)
      # 投稿2の詳細ページへ遷移する
      visit tweet_path(@tweet2)
      expect(current_path).to eq tweet_path(@tweet2)
      # 投稿2に編集ボタンがない
      expect(page).to have_no_link '編集', href: edit_tweet_path(@tweet2)
    end
    it 'ログインしていないと、投稿の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 投稿1に編集ボタンがない
      expect(page).to have_no_link '編集', href: edit_tweet_path(@tweet1)
    end
  end
end




RSpec.describe '投稿の削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context '投稿の削除ができるとき' do
    it 'ログインしたユーザーは、自らの投稿を削除できる' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@tweet1.user)
      # 投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 投稿を削除するとレコードの数が1減る
      expect{
        find_link('削除').click
      }.to change { Tweet.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには投稿1の内容が存在しない
      expect(page).to have_no_content("#{@tweet1.place_name}")
      expect(page).to have_selector('.place-image')
      expect(page).to have_no_content("#{@tweet1.address}")
      expect(page).to have_no_content("#{@tweet1.content}")
    end
  end
  context '投稿の削除ができないとき' do
    it 'ログインしたユーザーは、自分以外の投稿を削除できない' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@tweet1.user)
      # 投稿2の詳細ページへ遷移する
      visit tweet_path(@tweet2)
      # 投稿2に削除ボタンがない
      expect(page).to have_no_link '削除', href: tweet_path(@tweet2)
    end
    it 'ログインしていないと、投稿の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 投稿1の文章をクリックし、投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 投稿1に削除ボタンが無い
      expect(page).to have_no_link '削除', href: tweet_path(@tweet1)
    end
  end
end

RSpec.describe '投稿詳細', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
  end
  it 'ログインしたユーザーは、投稿詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@tweet.user)
    # 投稿の文章をクリックし、投稿詳細ページへ遷移する
    visit tweet_path(@tweet)
    # GoogleMapが表示されている
    expect(page).to have_selector('#map')
    # コメント用のフォームが存在する
    expect(page).to have_selector ('form')
  end
  it 'ログインしていない状態では、投稿詳細ページに遷移できるものの、コメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 投稿の文章をクリックし、投稿詳細ページへ遷移する
    visit tweet_path(@tweet)
    # GoogleMapが表示されている
    expect(page).to have_selector('#map')
    # コメント用のフォームが存在する
    expect(page).to have_no_selector 'form'
  end
end