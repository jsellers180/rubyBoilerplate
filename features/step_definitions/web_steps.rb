# frozen_string_literal: true

# General use step file. Common steps are defined here.

require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..',
                                   'support',
                                   'paths'))
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'rspec'
require 'capybara/poltergeist'

# This is certainly a module
module WithinHelpers
  def with_scope(locator)
    locator ? within(locator, match: :first) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^(?:|I )am on (.+)$/) do |page_name|
  ff = 'Mozilla/5.0 (Windows NT 6.1)'
  chrome = 'Chrome/66.0.3359.181'
  apple = 'AppleWebKit/537.36 (KHTML, like Gecko)'
  safari = 'Safari/537.36'
  # agent = 'User-Agent'
  page.driver.headers = { 'User-Agent' => "#{ff} #{apple} #{chrome} #{safari}" }
  visit path_to(page_name).to_s
end

When(/^(?:|I )fill in "(.*?)" with "(.*?)"?$/) do |field, value|
  expect(page).to have_content(field)
  fill_in(field, with: value)
end

Given(/^I refresh the page$/) do
  visit(current_path)
end

When(/^I click the first result$/) do
  page.all(:css, 'li.col-sm-6').first.click
end

When(/^(?:|I )follow "([^"]*)"$/) do |link|
  click_link_or_button(link, match: :first)
end

When(/^(?:|I )trigger click on id "(.*?)"$/) do |id_name|
  page.find(:id, id_name).trigger('click')
end

When(/^(?:|I )follow "(.*?)" within "(.*?)"$/) do |link, selector|
  click = click_link_or_button(link, match: :first)
  if selector
    with_scope(selector) { click }
  else
    click
  end
end

When(/^I click the "(.*?)" cucumber element$/) do |locator|
  find(locator, visible: true).click
  begin
    first(:css, locator, visible: true).click
  rescue Capybara::Poltergeist::MouseEventFailed,
         Capybara::Poltergeist::ObsoleteNode
    puts "JS Click: #{locator}"
    page.execute_script(%{ $($("#{locator}:visible").get(0)).click() })
  end
end

When(/^I play the movie$/) do
  expect(page).to have_css('.watch-now-button', wait: 4000)
  find(:css, '.screenshot')
  find(:css, '.watch-now-button').click
  sleep 60
  expect(page).not_to have_content('.watch-now-button', wait: 9000)
  # take_screenshot('test')
end

When(/^I click the "(.*?)" css element$/) do |locator|
  begin
    first(:css, locator, visible: true).click
  rescue Capybara::Poltergeist::MouseEventFailed,
         Capybara::Poltergeist::ObsoleteNode
    puts "JS Click: #{locator}"
    page.execute_script(%{ $($("#{locator}:visible").get(0)).click() })
  rescue Selenium::WebDriver::Error::UnknownError => e
    $stdout.puts e.message
  end
end

When(/^I take a screenshot$/) do
  time = Time.now.strftime('%m/%d/%Y/%H/%M')
  take_screenshot('test' + time)
end

When(/^I scroll "(.*?)"$/) do |scroll_amount|
  page.execute_script(" window.scrollBy(0,#{scroll_amount.to_i}) ")
end

When(/^I choose (.*?) with (.*?) within (.*?)$/) do |name, value, selector|
  with_scope(selector) do
    select(value, from: name)
  end
end

When(/^(?:|I )press "(.*?)"(?: within "(.*?)")?$/) do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

Then(/^(?:|I )should see "(.*?)"(?: within "(.*?)")?$/) do |text, selector|
  if selector.blank?
    expect(page).to have_content(text)
  else
    with_scope(selector) { expect(page).to have_content(text) }
  end
end

Then(/^(?:|I )should not see "(.*?)"(?: within "(.*?)")?$/) do |text, selector|
  if selector.blank?
    # Make sure specific content selection is NOT SHOWN on the page.
    # NOTE: 'expect(page).to' prevents deprecation message
    # from being shown as opposed to 'page.should_not'.
    expect(page).to have_no_content(text)
  else
    scope = page.first(:css, selector)
    scope.should_not have_content(text)
  end
end

Then(/^(?:|I )should see the selector "(.*?)"$/) do |selector|
  expect(page).to have_selector(selector)
end

Then(/^(?:|I )should not see the selector "(.*?)"$/) do |selector|
  expect(page).to have_no_selector(selector)
end

Then(/^my current path should be "(.*?)"$/) do |path|
  assert_equal(page.current_path, path)
end

Then(/^my current path should not match "(.*?)"$/) do |path|
  page.current_path.should_not match(path)
end

Then(/^link locator "(.*?)" should match "(.*?)"$/) do |locator, expected|
  actual = find(locator, match: :first)[:href]
  msg1 = "\n\nLocator #{locator} did not match #{expected}."
  msg2 = "\nGot: #{actual} (Using partial match on full URL)\n\n"
  assert(actual.match(expected), msg1 + msg2)
end

Then(/^the page title should be "(.*?)"$/) do |title|
  assert_equal(title, page.title)
end

Given(/^I wait for (.*?) seconds*$/) do |n|
  sleep n.to_f
end

Then(/^I execute script "(.*?)"$/) do |script|
  page.execute_script(script)
end

Then(/^links in page should have paths:$/) do |table|
  host = page.current_host
  failures = []
  table.hashes.each do |row|
    path_row = row['LINK_PATH']
    link_text = row['LINK_NAME']
    case expect(page).to have_content(link_text)
    when !row['LINK_NAME'].empty?
      link = page.find_first_link(link_text)
      link_path = link['href']
      if link_path.include?(host)
        expected_url = "expected: #{host}#{path_row}"
        bkn_path = "#{link_text} url was #{link_path} #{expected_url}"
        failures << bkn_path unless link_path == host + path_row
      else
        bkn_link = "#{link_text} path was #{link_path} expected: #{path_row}}"
        failures << bkn_link unless link_path == path_row
      end
    else
      failures << " Link text: #{link_text} does not exist"
    end
  end
  unless failures.empty?
    raise "\n*following issues were found:\n   -#{failures.join("\n   -")}\n\n"
  end
end

When(/^(?:|I )check "(.*?)"(?: within "(.*?)")?$/) do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When(/^(?:|I )choose "(.*?)"(?: within "(.*?)")?$/) do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When(/^"(.*?)"(?: within "(.*?)")? should not be a link$/) do |link, selector|
  with_scope(selector) do
    expect(page).to have_no_link(selector, link)
    # assert page.has_no_link?(link),
    # "#{link} is a link on page with in #{selector}"
  end
end

When(/^(?:|I )set "(.*?)"(?: with "(.*?)")?$/) do |selector, value|
  find(selector).set(value)
end

Then(/^I wait for the selector: "(.*?)"$/) do |selector|
  page.find(selector)
end

# TODO: This is not working
Then(/^id "(.*?)" is disabled$/) do |btn|
  # element = find(:id, btn)
  expect(page).to have_button(btn, disabled: true)
end

Then(/^The page should display "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
