Feature: Destroy a room
  As a user
  I should be able to destroy a room
  So I can discard the room when I am done with game

  Background: I am on the dashboard page
    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
    Given I have logged in with username and password: GrumpyBunny,123
    Given the room with room name as 'roomtest123' already exists
    And I am on the dashboard page

    Scenario:
      Given I have joined the room: 'roomtest123'
      When I click the button: 'Destroy Room'
      Then I should see: "Room destroyed successfully"
