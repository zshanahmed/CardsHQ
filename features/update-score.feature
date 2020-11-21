Feature: A way to keep track of score
  As a player of a card game
  I'd like to keep track of my score and see others scores
  so I can see who won/lost at the end

  Background: I've logged in and have created a game

    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
      | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
      | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
      | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |

    And I'm on the login page
    And I login to the account with info: "GrumpyBunny,123"
    And I am on the dashboard page
    And I click the button: 'Create New Room'
    And I submit room name as: 'Test Room 1'

Scenario: I update my score to 50
  When I fill in the score with: '50' and submit
  Then I should see: "Score updated!"