# frozen_string_literal: true

require 'net/http'

login_page = LoginPage.new
admin_member_page = AdminMembersPage.new
admin_films_page = AdminFilmsPage.new
admin_homepage_page = AdminHomepagePage.new

# evaluate whether I want to have this be admin_user or not
Given(/^I login as an admin user$/) do
  login_page.fill_form(login_page.prod_user, login_page.prod_pass)
  login_page.click_login_btn
  # take_screenshot('test')
end

When(/^I click the user drop down$/) do
  find(:xpath, ".//*[@id='header']/div[2]/ul/li[5]/button", match: :first).click
end

When(/^I should see Admin on the drop down$/) do
  expect(page).to have_content('Admin')
end

When(/^I click the Admin link$/) do
  link_path = ".//*[@id='header']/div[2]/ul/li[5]/ul/li[1]/a"
  find(:xpath, link_path, match: :first).click
  sleep 10
end

When(/^I search for a valid user$/) do
  admin_member_page.fill_search($env_prod_login)
  admin_member_page.click_go_btn
end

When(/^I should see that user in the results$/) do
  expect(page).to have_content($env_prod_login)
end

When(/^I should be logged in to the admin section$/) do
  # expect()
end

When(/^I enter the admin section$/) do
  step 'I am on the login page'
  step 'I login as an admin user'
  step 'I click the user drop down'
  step 'I should see Admin on the drop down'
  step 'I am on the admin page'
  step 'the page title should be "SpiritClips from Hallmark | Watch Family Friendly, Heartwarming Movies Online"'
end

When(/^The admin films page should be loaded correctly$/) do
  expect(page).to have_content('Images', wait: 5)
end

When(/^I search for the film (.*?)$/) do |film_name|
  find(:xpath, "//*[@id='film_filter']").click
  # expect(page).to have_field(admin_films_page.film_search_field, wait: 30), 'Unable to find the field'
  admin_films_page.search_films(film_name)
  admin_films_page.click_first_result
end

When(/^I should see the film in the results$/) do
  expect(page).to have_content('Hero: Website  (1462 x 646)')
end

When(/^I navigate to the admin homepage section$/) do
  admin_homepage_page.click_films_link
  click_link('Homepage-Slider')
end

When(/^The page should return successfully$/) do
  expect(page).to have_content('Homepage Slider', wait: 30)
end

When(/^I click Save all changes$/) do
  click('Save All Changes')
end

When(/^I detect if I am on the office network$/) do
  ip1 = '173.198.116.58'
  ip2 = '173.198.116.59'
  ip = Net::HTTP.get(URI('https://api.ipify.org'))
  if ip != (ip1 || ip2)
    raise 'Admin functions are restricted to the office'
  else
    puts 'My public IP Address is: ' + ip
  end
end
