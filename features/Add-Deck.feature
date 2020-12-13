Feature: Add a deck
  As a player in  a card game
  I'd like to add/ remove a deck
  So that I can play the game I want to play

  Background: I have created a room and am ready to play
    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
      | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
      | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
      | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |
    And I'm on the login page
    Given I login to the account with info: "GrumpyBunny,123"
    And I am on the dashboard page
    And I click the button: 'Create New Room'
    And I submit room name as: 'Test Room 1'

  Scenario: I add a deck
    When I add  1 decks
    Then Cards should have 104 cards

  Scenario: I add 2 decks and reset
    When I add 2 decks
    And I press reset
    Then Cards should have 52 cards