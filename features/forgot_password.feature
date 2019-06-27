@forgot_password @regression
Feature: Verifying forgot password flow

Scenario: Verifying Forgot Your Password Link On Login Page
  Given I am on the login page
  When I click Forgot your password? and verify FORGOT PASSWORD is displayed
  Then I should see "FORGOT PASSWORD"
  And I should see "email"

@smoketest
Scenario: Requesting Password Reset With A Valid Email
  Given I create a user
  And I click Log Out and verify Log In is displayed
  Given I am on the login page
  And I click Forgot your password? and verify FORGOT PASSWORD is displayed
  When I request a password reset with a valid email
  Then I should see a reset success message

Scenario: Requesting Password Reset With An Invalid Email
  Given I am on the login page
  And I click Forgot your password? and verify FORGOT PASSWORD is displayed
  When I request a password reset with an invalid email
  Then I should see "An account cannot be found with this email address. Please try again."
  
Scenario: Four Failed Attempts Leads To Forgot Password Page
  Given I create a user
  And I click Log Out and verify Log In is displayed
  And I click Log In and verify WELCOME BACK is displayed
  When I fill in the login form with valid email and invalid password four times
  Then I should see "You have attempted to log in too many times. Please reset your password and try again." within ".alert-danger"