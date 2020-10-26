require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全項目が存在する時、登録できる' do
        expect(@user).to be_valid
      end
      it '画像と自己紹介文が空でも登録できる' do
        @user.image = ''
        @user.introduction = ''
        expect(@user).to be_valid
      end
      it 'passwordが数字だけ、且つ6文字以上で登録できる' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to be_valid
      end
      it 'passwordが英語だけ、且つ6文字以上で登録できる' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        expect(@user).to be_valid
      end
      it '自己紹介文が100文字以内なら登録できる' do
        @user.introduction = "a" * 100
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'nicknameが11文字以上だと登録できない' do
        @user.nickname = 'a' * 11
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは10文字以内で入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに＠が無ければ登録できない' do
        @user.email = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'passwordが存在しても、password_confirmation空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordとpassword_confirmation一致していないと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it '自己紹介文が101文字だと登録できない' do
        @user.introduction = "a" * 101
        @user.valid?
        expect(@user.errors.full_messages).to include('自己紹介文は100文字以内で入力してください')
      end
    end
  end
end
