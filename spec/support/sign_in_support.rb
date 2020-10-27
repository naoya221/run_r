module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    all('input[name="commit"]')[0].click
    expect(current_path).to eq root_path
  end
end
