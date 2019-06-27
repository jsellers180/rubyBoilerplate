@watchlist @regression
Feature: Test cases for the watchlist functionality

Scenario: Users Start With An Empty Watchlist
  Given I entitle a user
  When I am on the watchlist page
  Then The watchlist should be empty

Scenario: Add A Movie To The Watchlist
  Given I entitle a user
  And I am on the rose hill film page
  When I add the movie to the watchlist
  And I am on the watchlist page
  Then I should see Rose Hill on the watchlist page

Scenario: Remove a Movie from the watchlist
  Given I add a movie to the watchlist
  And I am on the rose hill film page
  When I click remove from watchlist
  Then I am on the watchlist page
  And The watchlist should be empty