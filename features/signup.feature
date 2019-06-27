@signup @regression
Feature: Verifying sign up flow

@smoketest @prod
Scenario: Verify All Fields Are Present
  Given I am on the sign up page
  Then I verify the placeholder text on the sign up page

@negative @prod
Scenario Outline: Registration With "<Reg Test Case>"
  Given I am on the sign up page
  When I fill in the form with <Reg Test Case>
  Then id "submit" is disabled

  Examples:
  | Reg Test Case           |
  | only email and password |
  | an invalid email        |
  | a too short password    |
  | nothing                 |

@negative @prod
Scenario: Registration With Mismatching Emails
  Given I am on the sign up page
  When I fill in the form with mismatching emails
  And I submit the user form
  Then I should see an Emails do not match. error

Scenario: Registration With Valid Credentials
  Given I am on the sign up page
  When I fill in the form with all the valid credentials
  And I submit the user create form
  Then I am taken to the payment page
  And I display all the user info

@negative
Scenario Outline: Submitting Payment Page With "<Payment Test Case>"
  Given I create a user
  When I fill in the payment form fields with <Payment Test Case>
  Then id "btn-submit" is disabled

  Examples:
  | Payment Test Case           |
  | nothing                     |
  | no name on card             |
  | invalid credit card number  |

@TC197
  # https://rally1.rallydev.com/#/90987271964d/detail/testcase/42402940375
Scenario Outline: Registration With All Valid Inputs For <Sub Type> Subscription via the <Reg Path>
  Given I am on <Reg Path>
  And I fill in the form with all the valid credentials
  And I submit the user create form
  And I display all the user info
  When I fill in the payment form fields with all the credentials
  And I select <Sub Type> subscription
  And I submit the payment form
  Then I should see "WELCOME TO HALLMARK MOVIES NOW!"
  And I capture the current url
  And I follow "Start Watching!"
  And I should see the Welcome back message
  And I follow "Log Out"

  Examples:
  | Reg Path              | Sub Type |
  | standard sign up page | annual   |
  | standard sign up page | monthly  |
  | KOC sign up page      | annual   |
  | KOC sign up page      | monthly  |

@smoketest @life
Scenario: Registration With All Valid Inputs For annual Subscription via the standard sign up page
  Given I am on standard sign up page
  And I fill in the form with all the valid credentials
  And I submit the user create form
  And I display all the user info
  When I fill in the payment form fields with all the credentials
  And I select annual subscription
  And I submit the payment form
  Then I should see "WELCOME TO HALLMARK MOVIES NOW!"
  And I capture the current url
  And I follow "Start Watching!"
  And I should see the Welcome back message
  And I follow "Log Out"

@smoketest @life
Scenario: Registration With All Valid Inputs For annual Subscription via the standard sign up page
  Given I am on standard sign up page
  And I fill in the form with all the valid credentials
  And I submit the user create form
  And I display all the user info
  When I fill in the payment form fields with all the credentials
  And I select monthly subscription
  And I submit the payment form
  Then I should see "WELCOME TO HALLMARK MOVIES NOW!"
  And I capture the current url
  And I follow "Start Watching!"
  And I should see the Welcome back message
  And I follow "Log Out"

@smoketest
Scenario: Registration With All Valid Inputs For annual Subscription via the standard sign up page
  Given I am on KOC sign up page
  And I fill in the form with all the valid credentials
  And I submit the user create form
  And I display all the user info
  When I fill in the payment form fields with all the credentials
  And I select annual subscription
  And I submit the payment form
  Then I should see "WELCOME TO HALLMARK MOVIES NOW!"
  And I capture the current url
  And I follow "Start Watching!"
  And I should see the Welcome back message
  And I follow "Log Out"

@smoketest
Scenario: Registration With All Valid Inputs For annual Subscription via the standard sign up page
  Given I am on KOC sign up page
  And I fill in the form with all the valid credentials
  And I submit the user create form
  And I display all the user info
  When I fill in the payment form fields with all the credentials
  And I select monthly subscription
  And I submit the payment form
  Then I should see "WELCOME TO HALLMARK MOVIES NOW!"
  And I capture the current url
  And I follow "Start Watching!"
  And I should see the Welcome back message
  And I follow "Log Out"