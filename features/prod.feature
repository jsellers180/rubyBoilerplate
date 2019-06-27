@prod
Feature: prod smoketest

Scenario: Verifying Sign Up Link On Login Page
  Given I am on the home page
  And I click Log In and verify WELCOME BACK is displayed
  And I click Sign Up and verify START WATCHING is displayed
  Then I should see "START WATCHING!" within ".HeadingAlt"

Scenario Outline: Login With <Neg Test Case>
  Given I am on the home page
  And I click Log In and verify WELCOME BACK is displayed
  And I fill in the login form with <Neg Test Case>
  Then <result>

    Examples:
    | Neg Test Case                       | result                                                                        |
    | no inputs                           | id "submit" is disabled                                                       |
    | invalid email and no password       | id "submit" is disabled                                                       |
    | invalid email and password          | I should see "Unable to log you in. Please check your email and/or password." |

Scenario: Login With Prod Credentials
  Given I am on the home page
  When I click Log In and verify WELCOME BACK is displayed
  And I login to the site with prod credentials
  Then I should see "Welcome back"
  And I click Log Out and verify Log In is displayed

Scenario: Search While Logged In
  Given I am on the home page
  And I click Log In and verify WELCOME BACK is displayed
  And I login to the site with prod credentials
  When I am on the search page
  And I fill in "ss" with "Holy Joe"
  And I click the ".fa.fa-search.submit" css element
  Then I click the first result
  And I should not see "Watch this and more!"
