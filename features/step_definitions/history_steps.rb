# frozen_string_literal: true

history = HistoryPage.new

Given(/^I should see the empty history message$/) do
  expect(page).to have_content(history.no_history_msg, wait: 30)
end

Then(/^I should see (.*?) as a history item$/) do |film|
  expect(page).to have_content(film)
  # take_screenshot('test')
end
