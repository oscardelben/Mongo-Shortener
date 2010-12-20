Feature: Redirect to full url

  When someone access the shortened url, it should be redirected to the full url.
  
  Scenario: user access short url
    Given the following urls exist:
      | url                 | shortened |
      | http://example.com | dere2e   |
    When I go to the dere2e shortened page
    Then I should be redirected to "http://example.com"