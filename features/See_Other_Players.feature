Feature: See other players
  As a player of a card game
  I'd like to see other players number of cards
  so that I can think strategically about the game

  Background:
  # some players with specified amount of cards should be started

    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
      | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |

    Given I'm logged in with GrumpyBunny
    AND I'm on the show page


  Scenario: Player draws 2 cards
   When "GrumpyBunny" draws "2" cards
   Then I should see "GrumpyBunny" with "2" cards



