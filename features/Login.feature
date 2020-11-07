Feature: Allow a card game player to log-in

  Scenario:  Login as a player
    When I have entered my username: 'GrumpyBunny' and password: '123'
    And  I am on the Team1Selt2020 home page
    Then I should see a Flash message saying successful login.