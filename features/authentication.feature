@wip
Feature: Authentication
  As a user
  I want to register and sign in
  So that I can use Picdrip

  Scenario:
    Given I am not currently registered
    When I register
    Then I should be able to log in