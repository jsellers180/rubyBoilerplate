@cancel @regression
Feature: Verifying account cancellation

Scenario: Cancelling An Active Account
  Given I entitle a user
  And I am on the account page
  When I click the "#btn-cancel" css element
  Then I should see "YOUR SUBSCRIPTION HAS BEEN CANCELLED"

Scenario: Renewing A Cancelled Account
  Given I have cancelled an account
  When I click the "#btn-renew" css element
  Then I should see "WELCOME BACK! YOUR SUBSCRIPTION IS NOW ACTIVE."