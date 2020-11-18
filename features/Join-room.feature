Feature: Join a room
  As a user
  I want to join a room
  So I can play card games with my family

Background: :
  Given the following users exist:
    | username      | email                                | password      |
    | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |

  Given the room with room name as 'roomtest123' already exists

  Given I have logged in with username and password: GrumpyBunny,123
  And I am on the dashboard page

  Scenario: Attempt to successfully join a room
    When I click the button with text: 'Join A Room'
    And then I submit the correct invitation code
    Then I should see: "You have successfully joined the room"

  Scenario: Failed to join a room
    When I click the button with text: 'Join A Room'
    And then I submit the incorrect invitation code
    Then I should see: "Invitation token invalid!"
