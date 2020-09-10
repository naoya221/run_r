module CreatedRecord
  def created_record(user)
    # ログイン
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click
    # ベストタイム登録
    visit user_path(user)
    visit new_record_path
    all('input[name="commit"]')[0].click
    all('input[name="commit"]')[0].click
    all('input[name="commit"]')[0].click
    all('input[name="commit"]')[0].click
  end
end
