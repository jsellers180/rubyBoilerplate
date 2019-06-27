# frozen_string_literal: true

# Step file for the account cancellation feature.
# Will test cancellation and renewal.

account_page = AccountPage.new

require 'capybara/dsl'

When(/^I (.*?) my subscription$/) do |modify|
  case modify
  when 'cancel'
    click_button(account_page.cancel_sub_link)
    expect(page).to have_content(account_page.loading_screen, wait: 30)
    expect(page).to have_content(account_page.renew_btn, wait: 30)
  when 'renew'
    expect(page).to have_content(account_page.cancel_msg)
    click_button(account_page.renew_btn)
    expect(page).to have_content(account_page.loading_screen, wait: 15)
  else
    puts 'Subscription action not defined'
  end
end

When(/^I have cancelled an account$/) do
  step 'I entitle a user'
  step 'I am on the account page'
  step 'I click the "#btn-cancel" css element'
  step 'I should see "YOUR SUBSCRIPTION HAS BEEN CANCELLED"'
end
