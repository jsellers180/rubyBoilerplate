# frozen_string_literal: true

# Step file for the sign up feature.
# Includes registration of a user and purchasing.
user = UserClient.new
cc_info = CcClient.new
sign_up_page = SignUpPage.new
payment_page = PaymentPage.new
act_page = AccountPage.new

Given(/^I verify the placeholder text on the sign up page$/) do
  expect(page).to have_field(sign_up_page.fname_field)
  expect(page).to have_field(sign_up_page.lname_field)
  expect(page).to have_field(sign_up_page.email_field)
  expect(page).to have_field(sign_up_page.email_retype_field)
  expect(page).to have_field(sign_up_page.password_field)
end

# TODO: get user info for multi purchase
When(/^I fill in the form with (.*?)$/) do |condition|
  @valid_email = user.user_email
  case condition.strip.downcase
    # This test targets prod, so it is commented out.
    # when 'multi purchase credentials'
    #  email = "josh.sellers+#{Faker::Number.number(10)}@hallmarklabs.com"
    #  sign_up_page.fill_first_name('test')
    #  sign_up_page.fill_last_name('user')
    #  sign_up_page.fill_password('svodlifetest')
    #  sign_up_page.fill_email(email)
    #  sign_up_page.fill_confirm_email(email)
  when 'an invalid email'
    sign_up_page.fill_form(
      user.user_fname,
      user.user_lname,
      'nonemail',
      'nonemail',
      user.user_password
    )
  when 'a too short password'
    sign_up_page.fill_form(
      user.user_fname,
      user.user_lname,
      @valid_email,
      @valid_email,
      user.user_password(1, 7)
    )
  when 'only email and password'
    sign_up_page.fill_form(
      nil,
      nil,
      @valid_email,
      @valid_email,
      user.user_password
    )
  when 'mismatching emails'
    sign_up_page.fill_form(
      user.user_fname,
      user.user_lname,
      @valid_email,
      'someotheremail@mailcatch.com',
      user.user_password
    )
  when 'all the valid credentials'
    @user_fname = user.user_fname
    @user_lname = user.user_lname
    @user_full_name = @user_fname + ' ' + @user_lname
    @user_password = user.user_password
    sign_up_page.fill_form(
      @user_fname,
      @user_lname,
      @valid_email,
      @valid_email,
      @user_password
    )
    # when 'nothing'
    # no inputs here
  else
    puts 'Invalid entries'
  end
end

Given(/^I display all the user info$/) do
  puts @valid_email, @user_fname, @user_lname, @user_password
end

When(/^I submit the (.*?) form$/) do |condition|
  case condition.strip.downcase
  when 'user create'
    expect(page).to have_button(sign_up_page.continue_btn, wait: 5)
    sign_up_page.click_continue
    expect(page).to have_content('Payment Information', wait: 15)
  when 'user'
    expect(page).to have_button(sign_up_page.continue_btn, wait: 5)
    sign_up_page.click_continue
  when 'payment'
    expect(page).to have_button(payment_page.start_btn, wait: 5)
    payment_page.click_start
    expect(page).to have_content('Processing Payment', wait: 50)
    expect(page).to have_content('WELCOME TO HALLMARK MOVIES NOW!', wait: 60)
  when 'membership'
    expect(page).to have_button(act_page.update_btn, wait: 5)
    act_page.click_update_btn
    expect(page).to have_content(act_page.updating_msg, wait: 50)
    expect(page).to have_content(act_page.member_update_success, wait: 50)
  when 'account payment'
    expect(page).to have_button(act_page.update_btn, wait: 5)
    act_page.click_update_btn
    expect(page).to have_content(act_page.payment_update_success, wait: 30)
  else
    puts 'This form doesn\'t exist'
  end
end

When(/^I am taken to the payment page$/) do
  find("input[name='#{payment_page.radio_id}']", match: :first)
  puts "Account successfully created\n Email: #{@valid_email}"
end

Given(/^I create a user$/) do
  step 'I am on the sign up page'
  step 'I fill in the form with all the valid credentials'
  step 'I submit the user create form'
  step 'I display all the user info'
end

Given(/^I entitle a user$/) do
  step 'I create a user'
  step 'I fill in the payment form fields with all the credentials'
  step 'I select monthly subscription'
  step 'I submit the payment form'
end

Given(/^I entitle a user with verification$/) do
  step 'I create a user'
  step 'I fill in the payment form fields with all the credentials'
  step 'I select monthly subscription'
  step 'I submit the payment form'
  step 'I follow "Start Watching!"'
  step 'I should see "WELCOME TO HALLMARK MOVIES NOW!"'
  step 'I should see the Welcome back message'
  step 'I click the Log Out link'
  step 'I wait for 5 seconds'
end

When(/^I capture the current url$/) do
  purchase_url = URI.parse(current_url)
  puts purchase_url.to_s
end

# TODO: get valid multi purchase info
When(/^I fill in the payment form fields with (.*?)$/) do |condition|
  case condition.strip.downcase
  # when 'multi purchase credentials'
  #  payment_page.fill_cc('4358806582722195')
  #  payment_page.fill_zip('90403')
  #  payment_page.fill_cvn('169')
  #  payment_page.fill_full_name('test user')
  #  payment_page.select_exp_month(sprintf("%2.2d", 01))
  #  payment_page.select_exp_year(2020)
  when 'no name on card'
    payment_page.fill_form(
      cc_info.cc_num,
      cc_info.zip_code,
      cc_info.cvn,
      nil,
      cc_info.exp_month,
      cc_info.exp_year
    )
    # payment_page.fill_cc(cc_info.cc_num)
    # payment_page.fill_zip(cc_info.zip_code)
    # payment_page.fill_cvn(cc_info.cvn)
    # payment_page.fill_full_name(cc_info.full_name)
    # payment_page.select_exp_month(cc_info.exp_month)
    # payment_page.select_exp_year(cc_info.exp_year)
  when 'invalid credit card number'
    payment_page.fill_form(
      cc_info.invalid_cc,
      cc_info.zip_code,
      cc_info.cvn,
      cc_info.full_name,
      cc_info.exp_month,
      cc_info.exp_year
    )
  when 'all the credentials'
    @cc_num = cc_info.cc_num
    @cc_zip = cc_info.zip_code
    @cc_cvn = cc_info.cvn
    @cc_full_name = @user_full_name
    @cc_exp_month = cc_info.exp_month
    @cc_exp_year = cc_info.exp_year
    payment_page.fill_form(
      @cc_num,
      @cc_zip,
      @cc_cvn,
      @cc_full_name,
      @cc_exp_month,
      @cc_exp_year
    )
    page.has_css?(
      payment_page.start_watching_button,
      text: payment_page.start_btn,
      visible: true
    )
  end
end

Given(/^I select (.*?) subscription$/) do |type|
  case type.strip.downcase
  when 'monthly'
    choose(payment_page.monthly_radio, match: :first)
  else
    puts 'Defaulting to annual'
  end
end

And(/^I should see the Welcome back message$/) do
  expect(page).to have_content("Welcome back #{@user_fname}")
end

Then(/^I should see an (.*?) error$/) do |error_message|
  expect(page).to have_content(error_message)
end

# TODO: get a valid promo code
# uses a production promo code
Then(/^I enter a promo code$/) do
  # click('Got a coupon code?')
  find('#got-coupon').click
  fill_in('promo-code', with: 'BLOGGER100')
  click_button('Apply')
  expect(page).to have_content('$0.00', wait: 20)
end

# Given(/^I should receive email with the password reset information$/) do
#  sleep 60
#  Gmail.connect("spiritclipsqa@gmail.com", "spiritqa123") do |gmail|
#    assert gmail.inbox.find(:unread).count >= 1
#    gmail.inbox.find(:unread, :subject => "").each do |email|
#  assert_equal(email.message.subject,
# "Welcome to SpiritClips from Hallmark!",
# "\nEmail subject does not match\n")
# message_body = If you're still having trouble logging in, please email
#      assert email.message.body.match(/message_body/)
#    end
#  end
# end
