Feature:  Login for users
  As a user
  I should be able to login to my account
  so that I can start a game and play

  Background: I am on the login page

    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
      | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
      | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
      | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |

    Given I'm on the login page
    Then I should see a username field and password field

  Scenario: attempt to login with correct data
    When I enter username as "user"
    And password as "yes"
    Then I should see: "Login Successful"

  Scenario: attempt to login with not valid password
    When I enter username as "user"
    And password as ""
    Then I should see: "Invalid password"

  Scenario: attempt to login with not valid user
    When I enter username as ""
    And password as "yes"
    Then I should see: "Invalid password"

  Scenario: attempt to login with incorrect combination
    When I enter username as "GrumpyBunny"
    And password as "12"
    Then I should see: "Invalid user-id/email combination."

