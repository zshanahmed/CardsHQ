Feature: Discard/Draw
  As a player of a card game
  I'd like to draw/discard the cards in my hands
  So that I can empty my hand of useless cards.

  Background: Given that The following users exist:

    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
      | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
      | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
      | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |
    And I'm on the login page
    Given I login to the account with info: "GrumpyBunny,123"
    Given the room with room name as 'GrumpyRoom' already exists
    And I click the button with text: 'Join A Room'
    And then I submit the correct invitation code
    And I draw the following number of cards: '5'

Scenario: I discard 3 of my cards having 5 originally
  When 'GrumpyBunny' discards '3' cards
  Then 'GrumpyBunny' should only have '2' cards
