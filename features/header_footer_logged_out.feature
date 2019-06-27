@header_footer2 @regression
Feature: Verification of header and footer links across the site while no user is logged in

@prod @tcj2
Scenario Outline: Verifying Footer Links On <Page Name>
  Given I am on <Page Name>
  Then links in page should have paths:
    | LINK_NAME                   | LINK_PATH                                    |
    | About Hallmark Movies Now   | /about                                       |
    | Careers                     | https://careers.hallmark.com/Hallmarklabs/go/Hallmark-Labs/4210500     |
    | Hallmark Movies & Mysteries | http://www.hallmarkmoviesandmysteries.com/   |
    | Hallmark Drama              | http://www.hallmarkdrama.com/                |
    | Help                        | https://customercare.hmnow.com/              |
    | Accessibility               | /accessibility                               |
    | Contact                     | https://customercare.hmnow.com/              |
    | Privacy Policy              | /privacypolicy                               |
    | Terms & Conditions          | /termsandconditions                          |
    | Supported Devices           | /supported-devices                           |
    | Activate Your Device        | /activate                                    |
    | All Categories              | /all-categories                              |

  Examples:

    | Page Name                      |
    | the login page                 |
    | the homepage                   |
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
# React message will  be printed on the prices and membership page
# due to the web page code logging the message to the console

Scenario Outline: Verifying Header On <Page Name> While Logged Out
  Given I am on <Page Name>
  Then links in page should have paths:
    | LINK_NAME             |  LINK_PATH                    |
    | Join NOW!             | /signup/welcome               |
    | Log In                | /login                        |
    | MOVIES                | /movies/all-movies            |
    | HALLMARK HALL OF FAME | /movies/hallmark-hall-of-fame |
    | SERIES                | /tv/series		              |

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

Scenario: Verifying Header On Sign Up Page
  Given I am on the sign up page
  Then links in page should have paths:
    | LINK_NAME  | LINK_PATH |
    | Log In     | /login    |