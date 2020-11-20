Feature: a way to sign up for an account for the card game

  As a player
  I would like to create an account
  So that I can join games and play them

  Background: The following users have been added to database

    Given the following users exist:
    | username      | email                                | password      |
    | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
    | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
    | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
    | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
    | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |

    And I'm on the sign-up page

Scenario: Creating account with badly formatted Info:
  When I enter username,email,password and press submit: "gramp;!flop,botiqueBooth@gmail,c"
  Then I should see: "Invalid entry in one of the text-boxes"

Scenario: Creating a new user account when the username and email are already taken
  When I enter username,email,password and press submit: "GrumpyBunny,botiqueBooth@gmail,123"
  Then I should see: "Username, 'GrumpyBunny' has already been taken"

Scenario: Creating a new user account with fresh info
  When I enter username,email,password and press submit: "Glumps,glumps@gmail.com,123"
  Then I should see: "Account with Username 'Glumps' has been created"
