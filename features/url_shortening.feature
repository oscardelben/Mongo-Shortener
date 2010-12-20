Feature: url shortening

  As an internet user
  I want to shorten my urls
  So that I can include them on twitter
  
  @javascript
  Scenario: User enters url
    Given I am on the homepage
    And I want to shorten "http://my-url456.com"
    When I fill in "url" with "http://my-url456.com"
    And I press "Shorten"
    Then I should see its shortened version