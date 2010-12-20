Feature: Statistics

  Users should be able to see individual stats by appending .stats on top of a shortened url
  
  Scenario: Users should see stats
    Given the following urls exist:
      | url                         | shortened | hits_count |
      | http://example-preview.com  | cdewr4    | 34         |
    When I go to the cdewr4 stats page
    Then I should see "http://example-preview.com"
    And I should see "34"