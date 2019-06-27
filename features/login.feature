@login @regression

Feature: Verifying User Login
  Checking the response on login page for various scenarios

Background: Creating A User For The Following Test Cases
  Given I entitle a user
  And I click Log Out and verify Log In is displayed
  And the page title should be "Hallmark Movies Now - Watch Family Movies & Shows Online"

  @smoketest
Scenario: Verifying Sign Up Link On Login Page
  When I click Log In and verify WELCOME BACK is displayed
  And I click Sign Up and verify START WATCHING is displayed
  Then I should see "START WATCHING!" within ".HeadingAlt"

@negative
Scenario Outline: Login With <Neg Test Case>
  When I click Log In and verify WELCOME BACK is displayed
  And I fill in the login form with <Neg Test Case>
  Then <result>

  Examples:
  | Neg Test Case                       | result                                                                        |
  | no inputs                           | id "submit" is disabled                                                       |
  | invalid email and no password       | id "submit" is disabled                                                       |
  | invalid email and password          | I should see "Unable to log you in. Please check your email and/or password." |
  | valid email and an invalid password | I should see "Unable to log you in. Please check your email and/or password." |

@smoketest
Scenario: Login With Valid Email And Password
  Given I am on the login page
  And I display all the user info
  When I login to the site
  Then I should see "Welcome back"
  And I click Log Out and verify Log In is displayed

Scenario: Checking For "Remember Username" Cookie
  When I click Log In and verify WELCOME BACK is displayed
  And I enter login details
  And I check "rememberMe"
  And I click Login and verify Log Out is displayed
  Then I should see "Welcome back"
  And I check for "userName" within cookies
  And I click Log Out and verify Log In is displayed

Scenario: Verifying The "Remember Me" Cookie Does Not Exist When Not Checked
  Given I am on the login page
  When I login to the site
  Then I should see "Welcome back"
  And I check for "userName" within cookies does not exist
  And I click Log Out and verify Log In is displayed

Scenario: Verifying My Account Page
  Given I am on the login page
  When I login to the site
  And I wait for the selector: ".account"
  And I click the ".account" css element
  Then links in page should have paths:
    | LINK_NAME            | LINK_PATH           |
    | My Account           | /account            |
    | Activate Your Devices| /activate           |
    | My Watchlist         | /account/watchlist  |
    | History              | /account/history    |
    | Log Out              | /logout             |
  And I click the ".account" css element
  And I click Log Out and verify Log In is displayed

Scenario: Verifying Burger Links
  Given I am on the login page
  When I login to the site
  And I click the ".browse" css element
  Then links in page should have paths:
    |  LINK_NAME              | LINK_PATH          |
    |  Supported Devices      | /supported-devices |
  And I click Log Out and verify Log In is displayed

Scenario: Verifying Burger Links While Logged Out
  Given I am on the home page
  When I click the ".browse" css element
  Then links in page should have paths:
    |  LINK_NAME              | LINK_PATH           |
    |  Supported Devices      | /supported-devices  |
    |  Prices & Membership    | /prices-membership  |
  And I click Log Out and verify Log In is displayed