Feature: As a player of a card game
  I want to see cards played by other players
  So that I can think strategically about the game


  Background:

    Given the following users exist:
      | username      | email                         | password      |room_id |
      | Gleeb         | gleeb@gmail.com               | 123           |3       |
      | Bleeg        |  Gleeb3@gmail.com              | 1234          |3       |
      | blegg        |  blegg1@gmail.com              | 1234          |4       |

    And "Gleeb" and "Bleeg" both have "3" cards

    Scenario: Gleeb play one card
      When I'm logged in with "user1" with password "123" and in room "3"
      When "Gleeb" plays one card
      Then I should see an updated table with "Gleeb" in the first row


    Scenario: Bleeg plays one card
      When I'm logged in with "user1" with password "123" and in room "3"
      When "Bleeg" plays one card
      Then I should see an updated table with "Blleg" in the first row


    Scenario: Blegg plays one card
      When I'm logged in with "user1" with password "123" and in room "3"
      When "Blegg" plays one card
      Then I should not see any change in the played cards table

