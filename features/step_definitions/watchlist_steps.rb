# frozen_string_literal: true

watchlist = WLPage.new

When(/^I add the movie to the watchlist$/) do
  click_link(watchlist.add_to_wl)
  expect(page).to have_content(watchlist.remove_from_wl, wait: 5000)
end

When(/^I should see (.*?) on the watchlist page$/) do |content|
  expect(page).to have_content(watchlist.header)
  find(watchlist.film_css, match: :first).hover
  # take_screenshot('test')
  expect(page).to have_content(content)
end

When(/^I add a movie to the watchlist$/) do
  step 'I entitle a user'
  step 'I am on the rose hill film page'
  step 'I add the movie to the watchlist'
  step 'I am on the watchlist page'
end

When(/^I click remove from watchlist$/) do
  # find('.lazyloaded', match: :first).hover
  click_link(watchlist.remove_from_wl)
  expect(page).to have_content(watchlist.add_to_wl)
end

When(/^The watchlist should be empty$/) do
  expect(page).to have_content(watchlist.empty_wl)
end
