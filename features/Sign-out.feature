Feature: a way for players to log out of their accounts after they had logged in.
  As a player of a game
  I'd like to log out of my account
  To keep my account secure/ sign into a different account

  Background: The following users have been added to a database and the player is logged in

    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
      | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
      | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
      | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |

    And I'm on the login page

Scenario: I log out of my account
  When I login to the account with info: "GrumpyBunny,123"
  And press logout button
  Then I should see: "You have been logged out!"
  And Im taken to the login page

Scenario: I'm not logged in
  When I login to the account with info: "nonExistantAccount,nonExistantPassword"
  Then I shouldn't see a logout button