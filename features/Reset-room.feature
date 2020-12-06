Feature: Reset the room
  As a player of a card game
  So that I can start a new game
  I'd like to reset the player hands/ put cards back in deck

  Background: A room was created by a player

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

Scenario:  Someone draws all cards, plays half of them and then presses 'reset'
    When I draw the following number of cards: 52
    And 'GrumpyBunny' discards '26' cards
    And I press reset
    Then 'GrumpyBunny' should only have '0' cards
    And '52' cards should be in deck

