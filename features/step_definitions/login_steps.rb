# frozen_string_literal: true

# Step file for the login feature

login_page = LoginPage.new
user = UserClient.new
admin_member_page = AdminMembersPage.new
admin_homepage_page = AdminHomepagePage.new

Given(/^I enter login details$/) do
  login_page.fill_form(@valid_email, @user_password)
  # fill_in(login_page.email_field, with: @valid_email)
  # fill_in(login_page.password_field, with: @user_password)
end

Given(/^I login to the site$/) do
  step 'I enter login details'
  step 'I click Login and verify Log Out is displayed'
end

Given(/^I login to the site with prod credentials$/) do
  login_page.fill_form(login_page.prod_user, login_page.prod_pass)
  # fill_in(login_page.email_field, with: login_page.prod_user)
  # fill_in(login_page.password_field, with: login_page.prod_pass)
  step 'I click Login and verify Log Out is displayed'
end

Given(/^I fill in the login form with (.*?)$/) do |login_test|
  case login_test
  when 'invalid email and password'
    login_page.fill_form(user.user_email, user.user_password)
    expect(page).to have_button(login_page.login_btn, wait: 5)
    click_button(login_page.login_btn)
  when 'invalid email and no password'
    login_page.fill_form(user.user_email, nil)
    # fill_in(login_page.email_field, with: user.user_email)
  when 'valid email and an invalid password'
    login_page.fill_form(@valid_email, user.user_password(2, 5))
    expect(page).to have_button(login_page.login_btn, wait: 5)
    click_button(login_page.login_btn)
  when 'valid email and invalid password four times'
    4.times do
      step 'I fill in the login form with valid email and an invalid password'
    end
  end
end

Given(/^I click (.*?) and verify (.*?) is displayed$/) do |click_link, content|
  case click_link
  when 'Log Out'
    visit path_to(click_link).to_s # login_page.click_logout
    expect(page).to have_content('Log In', wait: 5)
    # sleep 15
    # page.should have_css('#Log In')
    # find('.hidden-xs.hidden-sm.account-nav>a')
    # TODO: expect(login_page.login_link).to include("Log In")
  when 'Log In'
    login_page.click_login_link
    expect(page).to have_content(content, wait: 5)
  when 'Sign Up'
    login_page.click_sign_up_link
    expect(page).to have_content(content, wait: 5)
  when 'Login'
    click_button(login_page.login_btn)
    expect(page).to have_content(content, wait: 5)
  when 'Forgot your password?'
    login_page.click_forgot_password_link
    expect(page).to have_content(content, wait: 5)
  when 'members'
    admin_member_page.click_members_link
    expect(page).to have_content(content, wait: 5)
  when 'films'
    admin_homepage_page.click_films_link
    expect(page).to have_content(content, wait: 5)
  else
    raise 'Error: No code for that link. See login_steps.rb'
  end
end

Given(/^I check for "([^"]*)" within cookies$/) do |cookie_name|
  assert page.driver.browser.cookies[cookie_name].present?
end

Given(/^I check for "([^"]*)" within cookies does not exist$/) do |cookie_name|
  assert page.driver.browser.cookies[cookie_name].nil?
end
