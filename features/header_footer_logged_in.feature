@header_footer1
Feature: Verification of header and footer links across the site while a user is logged in.

Background: creating a user to view headers/footers behind the pay wall
  Given I entitle a user

Scenario Outline: Verifying Header On <Page Name> While Logged In
  Given I am on <Page Name>
  Then links in page should have paths:
  | LINK_NAME             | LINK_PATH                     |
  | Log Out               | /logout                       |
  | MOVIES                | /movies/all-movies            |
  | HALLMARK HALL OF FAME | /movies/hallmark-hall-of-fame |
  | SERIES                | /tv/series			        |

  Examples:
    | Page Name                      |
    | the login page                 |
    | the home page                  |
    | the forgot password page       |
    | the all categories page        |
    | the terms and conditions page  |
    | the privacy policy page        |
    | the forgot password page       |
    | the all movies page            |
    | the hallmark hall of fame page |
    | the series page                |
    | the supported devices page     |
    | the prices and membership page |
    | the most popular page          |
    | the new movies page            |
    | the family movies page         |
    | the search page                |
    | the account page               |
    | the activate devices page      |
    | the watchlist page             |
    | the history page               |