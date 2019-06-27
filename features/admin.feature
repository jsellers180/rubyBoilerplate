@admin
Feature: Checking the basic functionality of the admin section

Background: Determine if the user can enter the admin portion of the site
  Given I detect if I am on the office network

Scenario: Admin Navigation Appears to An Admin User
  Given I am on the login page
  And I login as an admin user
  When I click the user drop down
  Then I should see Admin on the drop down

Scenario: Admin User Navigates to Admin Section
  Given I am on the login page
  Given I login as an admin user
  When I click the user drop down
  And I should see Admin on the drop down
  And I am on the admin page
  And the page title should be "SpiritClips from Hallmark | Watch Family Friendly, Heartwarming Movies Online"

Scenario: Perform a Search by Email
  Given I enter the admin section
  When I click members and verify admin: members is displayed
  And I search for a valid user
  Then I should see that user in the results

Scenario: Sanity check on the /admin/films page
  Given I enter the admin section
  When I click films and verify Images is displayed
  Then The admin films page should be loaded correctly

  @test
Scenario: Perform a search in the films section
  Given I enter the admin section
  When I click films and verify Homepage is displayed
  And I search for the film Holy Joe
  Then I should see the film in the results

Scenario: Sanity check on the /admin/homepage page
  Given I enter the admin section
  When I navigate to the admin homepage section
  And I click Save all changes
  Then The page should return successfully