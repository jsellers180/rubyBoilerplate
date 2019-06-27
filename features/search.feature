@search
Feature: Verifying search functionality from the point of view of a paid and unpaid user

@smoketest @prod @regression
Scenario: Verifying Search Functionality
  Given I am on the search page
  And I fill in "ss" with "Holy Joe"
  When I click the ".fa.fa-search.submit" css element
  Then I should see "YOUR RESULTS FOR ( HOLY JOE )"

@prod @smoketest @regression
Scenario: The User Is Presented With The Payment Option When Searching For A Movie When Not Logged In
  Given I am on the search page
  And I fill in "ss" with "Holy Joe"
  When I click the ".fa.fa-search.submit" css element
  And I click the first result
  Then I should see "Watch this and more! For as little as $4.99 per month"

@smoketest @regression
Scenario: The User Is Not Shown The Payment Option When Logged In
  Given I entitle a user
  Given I am on the search page
  And I fill in "ss" with "Holy Joe"
  When I click the ".fa.fa-search.submit" css element
  And I click the first result
  Then I should not see "Watch this and more!"

# The office ip is whitelisted, so these tests will fail if run from the office network.
@wip
Scenario: The user performs a XSS search
  Given I am on the search page
  And I fill in "ss" with "<script>alert('Hello, World!')</script>"
  When I click the ".fa.fa-search.submit" css element
  Then The page should display "ERROR The request could not be satisfied"

@wip
Scenario: The user performs a SQL injection search
  Given I am on the search page
  And I fill in "ss" with "' SELECT * FROM users"
  When I click the ".fa.fa-search.submit" css element
  Then The page should display "ERROR The request could not be satisfied"

# This functionality has been deprecated
# Scenario: Verifying a user can watch a rank=0 movie when not logged in
#  Given I am on the search page
#  And I fill in "ss" with "The Fork"
#  When I click the 0 ".fa.fa-search.submit" css element
#  Then I should see "YOUR RESULTS FOR ( THE FORK )" within ".search-results"
#  And I wait for 10 seconds
#  And I click the first result
#  Then I click the ".fa-play" css element
#  Then I wait for 10 seconds
#  Then I should see the selector "#hero-wrapper"