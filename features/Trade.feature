Feature: Trade cards
  As a player of a card game
  I'd like to trade cards
  with other players in the game

  Background: I've logged on to a game and have drawn some cards
    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
      | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
      | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
      | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |
    And I'm on the login page
    And I login to the account with info: "GrumpyBunny,123"
    And I click the button: 'Create New Room'
    And I submit room name as: 'Test Room 1'
    And I draw the following number of cards: 5

    Scenario: I trade cards
      When GrumpyBunny trades 3 cards with WarmBlanket
      Then 'GrumpyBunny' should only have '2' cards
      And 'WarmBlanket' should only have '3' cards