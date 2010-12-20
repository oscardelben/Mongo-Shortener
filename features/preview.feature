Feature: Preview
  
  An user should be able to preview the location of the final url before being redirected by appending .preview on a shortened url.
  
  Scenario: User foes to preview page
    Given the following urls exist:
      | url                 | shortened |
      | http://example.com  | dere2e    |
    When I go to the dere2e preview page
    Then I should see "http://example.com"