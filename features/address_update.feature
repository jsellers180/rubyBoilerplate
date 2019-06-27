@address_update
Feature: Verifying company address on the following pages

Scenario: Verifying Terms And Conditions New Company Address Is Shown
  Given I am on the terms and conditions page
  Then I should see "3130 Wilshire Blvd., 4th Floor"

Scenario: Verifying Terms And Conditions Old Company Address Not Shown
  Given I am on the terms and conditions page
  Then I should not see "1990 South Bundy Dr. Suite 620, Los Angeles, CA 90025"
  Then I should not see "1990 S. Bundy Ave, Los Angeles, California, 90025, USA"

Scenario: Verifying Privacy Policy Page New Company Address Is Shown
  Given I am on the privacy policy page
  Then I should see "3130 Wilshire Blvd., 4th Floor"

Scenario: Verifying Privacy Policy Page Old Company Address Not Shown
  Given I am on the privacy policy page
  Then I should not see "1990 South Bundy Dr. Suite 620, Los Angeles, CA 90025"
  Then I should not see "1990 S. Bundy Ave, Los Angeles, California, 90025, USA"