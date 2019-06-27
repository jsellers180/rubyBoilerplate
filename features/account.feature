@account @regression
Feature: Testing functions within a users account

Background: Creating a user to access the account page
  Given I entitle a user
  And I am on the account page

@smoketest
Scenario: Validating User Info On The Membership Tab
  Then I verify my user information is correct

@life
Scenario: Changing Membership Info
  And I display all the user info
  Given I change my user information
  And I display all the user info
  When I submit the Membership form
  Then I verify my user information is correct

# TODO: see if there is a way to get a device id for these test cases.
# Scenario: Activating A Device
# Scenario: Editing A Device Name
# Scenario: Deleting A Device

@life
Scenario: Changing The Users Password
  When I nav to Password tab and verify Current Password is displayed
  And I enter new password info
  And I click Log Out and verify Log In is displayed
  And I am on the login page
  Then I login to the site

Scenario: Navigating The Tabs
  When I nav to Devices tab and verify Activate a device is displayed
  And I nav to Password tab and verify Current Password is displayed
  And I nav to Membership tab and verify Billing Plan: is displayed
  And I nav to Payment tab and verify Name on Card is displayed

Scenario: Verifying payment info
  When I nav to Payment tab and verify Name on Card is displayed
  Then I verify my payment information is correct

Scenario: Updating payment info
  When I nav to Payment tab and verify Name on Card is displayed
  Then I change my payment information
  And I submit the account payment form
  And I verify my payment information is correct