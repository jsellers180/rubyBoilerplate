# frozen_string_literal: true

act_page = AccountPage.new
user = UserClient.new
cc_info = CcClient.new

When(/^I enter new password info$/) do
  @updated_password = user.user_password
  fill_in(act_page.current_password_fld, with: @valid_password)
  fill_in(act_page.new_password_fld, with: @updated_password)
  fill_in(act_page.confirm_password_fld, with: @updated_password)
end

When(/^I verify my user information is correct$/) do
  expect(page).to have_field(act_page.email_field, with: @valid_email)
  expect(page).to have_field(act_page.fname_field, with: @user_fname)
  expect(page).to have_field(act_page.lname_field, with: @user_lname)
  expect(page).to have_text('Monthly')
end

When(/^I change my user information$/) do
  @valid_email = user.user_email
  @user_fname = user.user_fname
  @user_lname = user.user_lname
  fill_in(act_page.email_field, with: @valid_email)
  fill_in(act_page.fname_field, with: @user_fname)
  fill_in(act_page.lname_field, with: @user_lname)
end

When(/^I nav to (.*?) tab and verify (.*?) is displayed$/) do |tab, content|
  click_link(tab, match: :first)
  expect(page).to have_content(content)
end

When(/^I verify my payment information is correct$/) do
  expect(page).to have_field(act_page.name_on_card_fld, with: @cc_full_name)
  expect(page).to have_field(act_page.zip_fld, with: @cc_zip)
  expect(page).to have_field(act_page.month_dropdown, with: @cc_exp_month)
  expect(page).to have_field(act_page.year_dropdown, with: @cc_exp_year)
end

When(/^I change my payment information$/) do
  @cc_full_name = cc_info.full_name
  @cc_zip = cc_info.zip_code
  @cc_num = cc_info.cc_num
  @cc_cvn = cc_info.cvn
  fill_in(act_page.name_on_card_fld, with: @cc_full_name)
  fill_in(act_page.zip_fld, with: @cc_zip)
  fill_in(act_page.ccn_fld, with: @cc_num)
  fill_in(act_page.cvn_fld, with: @cc_cvn)
end
