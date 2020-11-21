Feature: See other players
  As a player of a card game
  I'd like to see other players number of cards
  so that I can think strategically about the game

  Background:

    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |


    Scenario: I logged in, am looking at username and number of cards
      Given I'm logged in with "GrumpyBunny" with password "123" and in room "testroom182"
      Then I should see "GrumpyBunny" with "0" cards



