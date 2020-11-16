Feature: Create a room
  As a user
  I should be able to create a room
  So my friends can join the room

  Background: I am on the dashboard page
    Given the following users exist:
      | username      | email                                | password      |
      | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
    Given I have logged in with username and password: GrumpyBunny,123
    And I am on the dashboard page

    Scenario: I want to create a room
      When I click the button with text: 'Create New Room'
      And I submit room name as: 'Test Room 1'
      Then I should go to the room page with text: 'Welcome to the room Test Room 1'
      And I should see: "Room Test Room 1 was created successfully"