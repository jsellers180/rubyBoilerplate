# frozen_string_literal: true

$env_prod_pass = ENV['PROD_PASS']

# Login page object definition
class LoginPage
  include Capybara::DSL

  def email_field
    'email'
  end

  def password_field
    'password'
  end

  def fill_email(email)
    fill_in(email_field, with: email)
  end

  def fill_pw(password)
    fill_in(password_field, with: password)
  end

  def fill_form(email = nil, password = nil)
    fill_email(email)
    fill_pw(password)
  end

  def click_sign_up_link
    click_link('Sign Up')
  end

  def click_login_link
    click_link('Log In', match: :first)
  end

  def login_link
    'Log In'
  end

  def login_btn
    'Login'
  end

  def click_login_btn
    click_button(login_btn)
  end

  def forgot_password_link
    'Forgot your password?'
  end

  def click_forgot_password_link
    click_link('Forgot your password?')
  end

  def forgot_pw_email_field
    'email'
  end

  def forgot_pw_btn
    'Request Password'
  end

  def reset_success_msg
    "We have sent your password reset email to #{@valid_email}"
  end

  def reset_fail_msg
    'An account cannot be found with this email address. Please try again.'
  end

  def click_logout
    click_link('Log Out')
  end

  def prod_user
    $env_prod_login
  end

  def prod_pass
    $env_prod_pass
  end
end
