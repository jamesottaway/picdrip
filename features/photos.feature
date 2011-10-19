Feature:
  As a photographer
  I want to manage Photos in Picdrip
  So I don't have to upload them to photo sharing sites manually

  Scenario:
    Given I am a Picdrip user
    And I have created an Album
    When I upload a new photo
    Then I should be able to view the Photo