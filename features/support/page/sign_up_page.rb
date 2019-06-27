# frozen_string_literal: true

# sign up page object definition
class SignUpPage
  include Capybara::DSL

  def fill_first_name(fname)
    fill_in fname_field.to_s, with: fname
  end

  def fill_last_name(lname)
    fill_in lname_field.to_s, with: lname
  end

  def fill_email(email1)
    fill_in email_field.to_s, with: email1
  end

  def fill_confirm_email(email2)
    fill_in email_retype_field.to_s, with: email2
  end

  def fill_password(password)
    fill_in password_field.to_s, with: password
  end

  def fill_form(fname = nil, lname = nil, email1 = nil, email2 = nil, password = nil)
    fill_first_name(fname)
    fill_last_name(lname)
    fill_email(email1)
    fill_confirm_email(email2)
    fill_password(password)
  end

  def lname_field
    'last-name'
  end

  def fname_field
    'first-name'
  end

  def password_field
    'password'
  end

  def email_field
    'email'
  end

  def email_retype_field
    'email-retype'
  end

  def continue_btn
    'Continue'
  end

  def click_continue
    click_button('Continue')
  end
end
