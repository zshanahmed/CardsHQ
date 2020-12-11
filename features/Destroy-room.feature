Feature: Destroy a room
  As a user
  I should be able to destroy a room
  So I can discard the room when I am done with game

  Background: I am on the dashboard page
    Given I have logged in with email and password: botiqueBooth@gmail.com,12345689
    Given the room with room name as 'roomtest12345689' already exists
    And I am on the dashboard page

    Scenario:
      Given I have joined the room: 'roomtest12345689'
      When I click the button: 'Destroy Room'
      Then I should see: "Room destroyed successfully"
