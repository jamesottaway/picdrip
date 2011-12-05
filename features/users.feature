Feature: Authentication
  As a user
  I want to register and sign in
  So that I can use Picdrip

  Scenario:
    Given I am not currently registered
    When I register
    Then I should be able to log in
  
  Scenario:
    Given I am a Picdrip user
    And I am not authenticated to Flickr
    When I authenticate to Flickr
    Then I should see that I have authenticated to Flickr