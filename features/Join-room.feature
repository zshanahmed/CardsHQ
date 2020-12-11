Feature: Join a room
  As a user
  I want to join a room
  So I can play card games with my family

  Background: :
    Given I have logged in with email and password: botiqueBooth@gmail.com,12345689
#    Given the room with room name as 'roomtest12345689' already exists
#    And I am on the dashboard page
#
  Scenario: Attempt to successfully join a room
#    When I click the button: 'Join Room'
#    And then I submit the correct invitation code
    Then I should see the message: "You have successfully joined the room"
#
#  Scenario: Failed to join a room
#    When I click the button: 'Join Room'
#    And then I submit the incorrect invitation code
#    Then I should see: "Invitation token invalid!"