Feature: Manage entries
	Background:
		Given a user with email "team@nanny.com" and password "password"
	
		And the following memory boxes:
			| title  |
			| Ben    |
		And a memory box with the following entries:
			|       description             |
			| Billy taking his first steps  |

	Scenario: Delete an entry
		Given I send a delete request for the entry
		Then the memory box should have 0 entries

	Scenario: Update an entry
		Given I update the entry with the following attributes:
			| description |
			| new desc    |
		Then the entries description should be "new desc"