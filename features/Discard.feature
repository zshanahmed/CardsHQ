Feature: Discard/Draw
  As a player of a card game
  I'd like to draw/discard the cards in my hands
  So that I can empty my hand of useless cards.

  Background: Given that The following users exist:

    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 12345689           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234568945689          |
      | WarmBlanket   | Beethoven@vienna.edu                 | @@##$$%%^^&&**            |
      | softPillow    | saltedButterWasAMistake@walmart.com  | abpoiafnasklf    |
      | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |
    And I'm on the login page
    Given I login to the account with info: "GrumpyBunny,12345689"
    And I am on the dashboard page
    And I click the button: 'Create New Room'
    And I submit room name as: 'Test Room 1'
    And I draw the following number of cards: 5

Scenario: I discard 3 of my cards having 5 originally
  When 'GrumpyBunny' discards '3' cards
  Then 'GrumpyBunny' should only have '2' cards
