# frozen_string_literal: true

# Step file for the forgot password flow

login_page = LoginPage.new
user = UserClient.new

Given(/^I request a password reset with (.*?)$/) do |condition|
  case condition
  when 'a valid email'
    expect(page).to have_field(login_page.forgot_pw_email_field)
    fill_in(login_page.forgot_pw_email_field, with: @valid_email)
    find('#email').send_keys(:enter)
    # expect(page).to have_button(login_page.forgot_pw_btn, wait: 15)
    # click_button(login_page.forgot_pw_btn)
    expect(page).to have_content(login_page.reset_success_msg, wait: 30)
  when 'an invalid email'
    fill_in(login_page.forgot_pw_email_field, with: user.user_email)
    # expect(page).to have_button(login_page.forgot_pw_btn, wait: 15)
    find('#email').send_keys(:enter)
    # click_button(login_page.forgot_pw_btn)
    # Sometimes the button doesn't become enabled.
    # The code above is a workaround.
    expect(page).to have_content(login_page.reset_fail_msg, wait: 30)
  end
end

Then(/^I should see a reset success message$/) do
  expect(page).to have_content(login_page.reset_success_msg)
end
