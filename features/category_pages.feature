@category_page @regression
Feature: Checking links for category pages

Scenario: Verifying Links To Different Categories
  Given I am on the all categories page
  Then links in page should have paths:
       |  LINK_NAME                  | LINK_PATH                     |
	   |  Hallmark Hall of Fame      | /movies/hallmark-hall-of-fame |
	   |  Streaming Exclusive        | /movies/exclusive             |