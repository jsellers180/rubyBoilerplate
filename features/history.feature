Feature: Test cases for the history feature

Scenario: New Users History Is Empty
  Given I entitle a user
  When I am on the history page
  Then I should see the empty history message
# video playback is not supported by phantomjs http://phantomjs.org/supported-web-standards.html
# Commenting this out in case playback is supported at some point
# Scenario: History Is Populated
#  Given I entitle a user
#  And I am on the rose hill film page
#  When I play the movie
#  And I am on the history page
#  Then I should see Rose Hill as a history item