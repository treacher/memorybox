Feature: Manage memory boxes
  
  Background:
    Given a user with email "team@nanny.com" and password "password"
    And the following memory boxes:
      |   title   |
      | Charlotte |

  Scenario: Delete memory box
    Given I send a delete request for the memory box
    Then the user should have 0 memory boxes

  Scenario: Update memory box
    Given I send a put request for the memory box with the JSON:
    """
    {
      "memory_box": {
        "title": "James"
      }
    }
    """
    Then the memory boxes title should be "James"