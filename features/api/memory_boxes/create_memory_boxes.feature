Feature: Create albums

	Background:
	 Given a user with email "team@nanny.com" and password "password"

	Scenario: Create Memory Box
		Given I post a request to create a memory box
    """
    {
      "memory_box": {
        "title": "Jenna"
      }
    }
    """
    Then the user should have 1 memory box